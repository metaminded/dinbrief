# encoding: utf-8

require 'dinbrief'

#
# Firstly, subclass Dinbrief::Letter to get the header/footer
# stuff sorted out.
#
class MyLetter < Dinbrief::Letter
  # define a header
  def header
    image(File.join(File.dirname(__FILE__), "metaminded.png"),
      :at => [0.mm, 35.mm],
      :fit => [80.mm, 22.mm]
    )
    text_box(%{metaminded UG (haftungsbeschränkt)
      Ulmer Str. 124
      im Wi.Z
      73431 Aalen

      www.metaminded.com
    },
      :at => [105.mm, 35.mm],
      :width => 85.mm,
      :align => :left,
      :size => 10.pt
    )
  end

  # define a footer
  def footer
    text_box(%{metaminded UG (haftungsbeschränkt) – Ulmer Str. 124 – 73431 Aalen
    Handelsregisternummer: HRB 724169 – Registergericht: Amtsgericht Ulm/Donau – USt.ID.: DE267558458
    Geschäftsführer: Dr. Peter Horn
    },
      :at => [20.mm, 12.mm],
      :width => 140.mm,
      :align => :center,
      :size => 8.pt,
    )
  end
end

#
# then, use this subclass to render the actual letter
#
MyLetter.letter('more_serious.pdf') do |db|
  db.return_address 'metaminded UG – Ulmer Straße 176 – 73233 Aalen'
  db.oursign        "PH"
  db.yoursign       "DHH"
  db.yourmessage    "24.12.2011"
  db.name           "Dr. Peter Horn"
  db.phone          "05604 - 919937"
  db.fax            "05604 - 919938"
  db.email          "ph@metaminded.com"
  db.address        "David Heinemeier-Hansson\n37signals, LLC\n30 North Racine Avenue #200\nChicago, Illinois 60607\nUSA"
  db.subject        "Thanks a lot for giving us Rails"
  db.body do |letter|
    letter.text %{Dear David and all you colleagues,

      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

      To impress people, I add a useless table:
      }

    letter.table [["Animal", "Programming Language", "coincidence"],
      ["Penguin",  "C",      "213" ],
      ["Platypus", "ObjC",   "143" ],
      ["Cat",      "Ruby",   "47"  ],
      ["Dog",      "Python", "23"  ],
      ["Olm",      "PHP",    "876" ]
    ]

    letter.text %{
      Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum.

      Curabitur ullamcorper ultricies nisi. Nam eget dui.

      Best Regards,
    }

  end
end

