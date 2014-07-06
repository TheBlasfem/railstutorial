require 'spec_helper'

describe 'User Page' do 
  
  subject { page }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_content("Sign up") }
  	it { should have_title(full_title("Sign up")) }
  end

  describe "profile page" do 
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }
  	it { should have_content(user.name) }
  	#it { should have_content(user.email) }
  end

  describe "sign up" do 
    let(:submit) { "Create User" }
    before { visit signup_path }
    
    describe "with invalid information" do
      it "should not create user" do 
        expect { click_link submit }.not_to change(User.count)
      end
    end
    
    describe "with valid information" do 
      before do
        fill_in "Name", with: "Julio"
        fill_in "Email", with: "probando@gmail.com"
        fill_in "Password", with: "12345678"
        fill_in "Confirmation", with: "12345678"
      end
      it "should create user" do
        expect { click_link submit }.to change(User.count).by(1)
      end
    end
  end
end