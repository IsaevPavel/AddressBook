require 'sqlite3'

DB=SQLite3::Database.open("address_book.db")
DB.results_as_hash=true

class Contact
  attr_reader :id, :email_type
  def initialize name, id=nil, email=nil, email_type=nil, number=nil, number_type=nil, address=nil, address_type=nil
    @name=name
    @id=id
    @email=email
    @email_type=email_type
    @number=number
    @number_type=number_type
    @address=address
    @address_type=address_type
  end
  def save
    DB.execute("insert into contacts (name) values ('#{@name}')")
    @id = DB.execute("select last_insert_rowid()")[0][0]
  end
  def prompt text
    puts text
    gets.chomp
  end
  def dell
    DB.execute("delete from contacts where id=#{@name}")
    DB.execute("delete from email where contact_id=#{@name}")
    DB.execute("delete from number where contact_id=#{@name}")
  end
  def self.all
    DB.execute("select contacts.id, contacts.name, email.email, email.type, number.number, address.address
                 from contacts, email, number, address
                where email.contact_id=contacts.id and number.contact_id=contacts.id and address.contact_id=contacts.id").map do |row|
      Contact.new(row['name'], row['id'], row['email'], row['email.type'], row['number'], row['number.type'], row['address'], row['address.type'])
    end
  end
  def to_s
    "#{@id}. Name:#{@name==""? 'no name' : @name }; email:#{@email==""? 'no email' : @email}; type email:#{@email_type}; number:#{@number==""? 'no number' : @number};"+
        " number_type:#{@number_type==""? 'no number type' : @number_type};"+
        " address:#{@address==""? 'no address' : @address};"+
        " address_type:#{@address_type==""? 'no address type' : @address_type};"
  end
end