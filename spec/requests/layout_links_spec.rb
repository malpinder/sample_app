require 'spec_helper'

describe "LayoutLinks" do

  pages = {}
  pages[:home] =    { :linkname => '',        :path => 'root_path',     :title => 'Home' }
  pages[:about] =   { :linkname => 'about',   :path => 'about_path',    :title => 'About' }
  pages[:contact] = { :linkname => 'contact', :path => 'contact_path',  :title => 'Contact' }
  pages[:help] =    { :linkname => 'help',    :path => 'help_path',     :title => 'Help' }
  pages[:signup] =  { :linkname => 'signup',  :path => 'signup_path',   :title => 'Sign up' }
  pages[:signin] =  { :linkname => 'signin',  :path => 'signin_path',   :title => 'Sign in' }
 # pages[:signout] = { :linkname => 'signout', :path => 'signout_path',  :title => 'Sign out' }

  pages.each do |pagename, page|
    it "should have a #{page[:title]} page" do
      get '/' + page[:linkname]
      response.should have_selector('title', :content => page[:title])
    end

    it "should have the correct links" do
      visit root_path
      click_link page[:title]
      response.should have_selector('title', :content => page[:title])
    end
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path, :content => "Sign in")
    end
  end

  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Profile")
    end
  end

end

