require 'sqlite3'
require './lib/contacts'
require './lib/email'
require './lib/number'
require './lib/address'
require './lib/edit_data'

def welcome
  puts "Welcome to awesome address-book!"
  menu
end
def menu
  choice=nil
  until choice=='exit'
    puts "\nInput 'a' to add contacts, 'l' to view all list, 'd' to delete contacts, 'e' edit"
    puts "\nInput 'exit' to exit"
    choice=gets.chomp
    case choice
      when 'a'
        add
      when 'l'
        list
      when 'd'
        delete
      when 'e'
        edit
      else
        invalid
    end
  end
end
def add
  puts "Please enter the name of new contact"
  choice=gets.chomp
  contact=Contact.new choice
  contact.save
  puts "Please enter the email of new contact"
  choice1=gets.chomp
  puts "Please enter the type of email"
  choice2=gets.chomp
  email=Email.new(choice1, choice2, contact)
  email.save
  puts "Please enter the number of new contact"
  choice=gets.chomp
  puts "Please enter the type number of new contact"
  choice1=gets.chomp
  number=Number.new choice, choice1, contact
  number.save
  puts "Please enter the address of new contact"
  choice=gets.chomp
  puts "Please enter the type address of new contact"
  choice1=gets.chomp
  address=Address.new choice, choice1, contact
  address.save
end
def list
  contacts=Contact.all
  contacts.each do |contact|
    puts contact
  end
  puts @email_type
end
def edit
  list
  puts "Press number column to edit"
  @choice=gets.chomp
  puts EditData.key @choice
  puts "Press 'n' to change name, 'e' to email, 'e_t' email type, 'p' to number, 'p_t' to number_type,'a' to address, 'a_t' to address type"
  @choice_element=gets.chomp
  puts "Enter change"
  next_choice=gets.chomp
  EditData.change @choice_element, next_choice
  puts EditData.key @choice
  puts "Changes successful!"
end
def delete
  list
  puts "Press what number to delete"
  choice=gets.chomp
  contact=Contact.new choice
  contact.dell
end
def invalid

end
welcome
