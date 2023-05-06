require 'ruby-nfc'

class Rfid
    @@reader = NFC::Reader.all
    def read_uid
        @@reader[0].poll(Mifare::Classic::Tag) do |tag|
		return tag.uid_hex.upcase
  	end
    end
end
