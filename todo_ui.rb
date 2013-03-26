require 'active_record'
require './lib/address'
require './lib/contact'
require './lib/email'
require './lib/number'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "NO so many things left to be done! Welcome"
  main
end
def main
  choice=nil
  until choice == 'exit'
    puts "Press 'l' to list your contacts, 'a' to add a date of new contacts, 'c' to edit, or 'd' to delete contact"
    puts "Press 'exit' to exit."
    choice=gets.chomp
    case choice
      when 'l'
        list
      when 'a'
        add
      when 'e'
        edit
      when 'd'
        del
      else
        invalid
    end
  end
end
def prompt text
  puts text
  gets.chomp
end
def list
  puts "All contact:"
  Contact.all.each do |contact|
    puts contact
  end
end
def add
  contact_name=prompt "Input name new contact"
  contact=Contact.new(:name => contact_name)
  contact.save
  email_name=prompt "Input email new contact"
  type_name=prompt "Input email type new contact"
  email=Email.new(:name => email_name, :email_type => type_name)
  email.save
  new_number=prompt "Input number new contact"
  number_type=prompt "Input number type new contact"
  number=Number.new(:name => new_number, :number_type => number_type)
  number.save
  new_address=prompt "Input address new contact"
  address=Address.new(:name => new_address)
  address.save
end
def edit
  list
  id=prompt"Press number to edit or 'exit' to exit"
  until id == 'exit'
    Contact.view_id id
    choice=prompt "Press 'n' to change name, 'e' to change email, 'e_t' to change email type, 'num' to change number, 'n_t' "+
                      "to change number type, or 'a' to change address"
    change=prompt "Input change"
    Contact.edit id, choice, change
    puts "Change successful!"
    break
  end
end
def del
  list
  delete_id=prompt"Press number to delete or 'exit' to exit"
  until delete_id=='exit'
    find_id=[]
    Contact.all.each do |contact|
      find_id<<contact.id
    end
    if find_id.count(delete_id.to_i)!=0
      Contact.find(delete_id).delete
      Email.find(delete_id).delete
      Number.find(delete_id).delete
      puts "Delete is complete!"
    else
      puts "Incorrect number"
    end
    break
  end
end
def invalid
  "Something is wrong!"
end
welcome