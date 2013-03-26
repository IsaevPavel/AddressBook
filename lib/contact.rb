class Contact<ActiveRecord::Base
  has_many :address
  has_many :email
  has_many :number
  def to_s
    "#{self.id}. Name: #{self.name}; Email: #{Email.find(self.id).name};"+
        " Email type: #{Email.find(self.id).email_type};"+
        " Number: #{Number.find(self.id).name};"+
        " Number type: #{Number.find(self.id).number_type};"+
        " Address: #{Address.find(self.id).name};"
  end
  def self.view_id id
    puts "#{self.find(id).id}. Name: #{self.find(id).name}; Email: #{Email.find(id).name};"+
             " Email type: #{Email.find(id).email_type};"+
             " Number: #{Number.find(id).name};"+
             " Number type: #{Number.find(id).number_type};"+
             " Address: #{Address.find(id).name};"
  end
  def self.edit id, choice, change
    if choice=='n'
      contact_update=Contact.find(id)
      contact_update.update_attributes(:name => change)
    elsif choice=='e'
      @email_update=Email.find(id)
      @email_update.update_attributes(:name => change)
    elsif choice=='e_t'
      @email_update.update_attributes(:email_type => change)
    elsif choice=='num'
      @number_update=Number.find(id)
      @number_update.update_attributes(:name => change)
    elsif choice=='num_t'
      @number_update.update_attributes(:number_type => change)
    elsif choice=='a'
      address_update=Address.find(id)
      address_update.update_attributes(:name => change)
    else
      "Somethings is bad!"
    end
  end
end
