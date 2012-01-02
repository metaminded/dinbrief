# encoding: utf-8

require 'dinbrief'

Dinbrief.letter('hello.pdf') do |db|
  db.return_address 'metaminded UG * Ulmer Straße 176 * 73233 Aalen'
  db.oursign        "PH"
  db.yoursign       "MZ"
  db.yourmessage    "24.12.2011"
  db.name           "Dr. Peter Horn"
  db.phone          "05604 - 919937"
  db.fax            "05604 - 919938"
  db.email          "ph@metaminded.com"
  db.subject        "Hooooray!"
  db.address        "ropa GmbH & Co. KG\n-- Herrn Marco Zapf --\nGoethestraße 5\n77624 Schwäbisch Gmünd\nGERMANY"
  db.subject        "Frohe Weihnachten von metaminded!"
  db.body <<-TEXT
  ....
  TEXT
end

