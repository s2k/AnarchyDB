#! env ruby

require 'sinatra'
require 'amazing_print'
require 'digest'
require 'random/formatter'

set :bind, '0.0.0.0'

STORAGE_DIR = File.join( File.dirname(__FILE__), '..', 'storages')

def known_dbs
  Dir[STORAGE_DIR + '/*'].map{|dir_name| File.basename dir_name}
end

raise "No storage folder found at '#{STORAGE_DIR}'" unless File.directory?(STORAGE_DIR)

get '/databases' do
  known_dbs.join("\n") + "\n"
end

def path_for(dbname)
  File.join(STORAGE_DIR, dbname)
end

post '/new/:dbname' do |dbname|
  folder_name = path_for(dbname)
  return [400, "Already exists\n"] if File.exist?(folder_name)

  begin
    Dir.mkdir(folder_name)
  rescue
    return [500, "Couldn't create storage\n"]
  end

  [200, "Storage #{dbname} created\n"]
end

post '/:dbname' do |dbname|
  storage_key = Digest::SHA256.hexdigest( "#{Random.uuid}-#{DateTime.now}+#{SecureRandom.random_bytes(30)}")
  file_name = File.join(path_for(dbname), storage_key)
  File.open(file_name, 'w'){|f| f.puts request.body.string }
  storage_key
end

get '/:dbname/:storage_key' do |dbname, storage_key|
  file_name = File.join(path_for(dbname), storage_key)
  return [404, "No data for key #{storage_key} found\n"] unless File.exist?(file_name) && File.file?(file_name)

  File.read(file_name)
end


