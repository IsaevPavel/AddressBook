class EditData
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
  def self.key number
    @number_id=number
    DB.execute("select contacts.id, contacts.name, email.email, email.type, number.number
                 from contacts, email, number where contacts.id=#{number} and email.contact_id=contacts.id
                  and number.contact_id=contacts.id").map do |row|
      Contact.new(row['name'], row['id'], row['email'], row['email.type'], row['number'], row['number.type'], row['address'], row['address.type'])
    end
  end
  def self.change row, word
    if row=='n'
      DB.execute("update contacts set name = '#{word}' where id=#{@number_id}")
    elsif  row=='e'
      DB.execute("update email set email = '#{word}' where contact_id=#{@number_id}")
    elsif row=='e_t'
      DB.execute("update email set type = '#{word}' where contact_id=#{@number_id}")
    elsif row=='p'
      DB.execute("update number set number = '#{word}' where contact_id=#{@number_id}")
    elsif row=='p_t'
      DB.execute("update number set type = '#{word}' where contact_id=#{@number_id}")
    elsif row=='a'
      DB.execute("update address set address = '#{word}' where contact_id=#{@number_id}")
    elsif row=='a_t'
      DB.execute("update address set type = '#{word}' where contact_id=#{@number_id}")

    end
  end
  def to_s
    "#{@id}. Name:#{@name}; email:#{@email}; type email:#{@email_type}; number:#{@number}; number_type:#{@number_type}; address:#{@address}; address_type:#{@address_type};"
  end
end