require 'spec_helper'

describe "LayoutLinks" do

  pages = {}
  pages[:home] =    { :linkname => '',        :path => 'root_path',     :title => 'Home' }
  pages[:about] =   { :linkname => 'about',   :path => 'about_path',    :title => 'About' }
  pages[:contact] = { :linkname => 'contact', :path => 'contact_path',  :title => 'Contact' }
  pages[:help] =    { :linkname => 'help',    :path => 'help_path',     :title => 'Help' }
  pages[:signup] =  { :linkname => 'signup',  :path => 'signup_path',   :title => 'Sign up' }

  # pages[:signin] =  { :linkname => 'signin',  :path => 'signin_path',   :title => 'Sign in' }

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

end

