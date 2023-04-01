# AnarchyDB

This is `AnachyDB`, ungoverned data storage.

Why 'Anarchy'?

* There are no automated tests…
* …or rules.
* Only stores limited data and you need to figure out the limitation your self
* When storing data you get a key back. Don't lose that key, as this is the only way to get back the data from the server. 
* There is no querying whatsoever, except providing the key that was generated when storing

# IMPORTANT

* It's strongly recommended against (!) using this in any form of production. (For reference see date of the initial commit.)

## Dependencies

You'll need a working Ruby 3.2.2.

## Usage

1. Clone the repository
2. `cd` into the cloned repo: `cd anarchydb`
3. Run bundler: `bundle install`
4. Run the `AnarchyDB`server: `./bin/anarchydb.rb`
