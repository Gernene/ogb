class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:id])
    @contact.send_email(@contact.name, @contact.email, @contact.title, @contact.message)
    flash[:success] = "Message sent! We will reply soon!"
    redirect_to new_contact_path
  end
end