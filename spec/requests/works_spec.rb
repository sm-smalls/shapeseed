require 'spec_helper'

describe "Works" do
  before(:each) do 
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end
  
  describe "creation" do
    describe "failure" do
      it "should not make a new work" do
        lambda do
          visit root_path
          fill_in :work_content, :with => ""
          fill_in :work_age, :with => 0
          fill_in :work_where, :with => ""
          fill_in :work_category, :with => ""
          fill_in :work_name, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Work, :count)
      end
    end

    describe "success" do
      it "should make a new work" do
        content = "I liked it"
        age = 15
        where = "isbn"
        category = "book"
        name = "Aops"
        lambda do
          visit root_path
          fill_in :work_content, :with => content
          fill_in :work_age, :with => age
          fill_in :work_where, :with => where
          fill_in :work_category, :with => category
          fill_in :work_name, :with => name
          click_button
          response.should have_selector("span.content", :content => content)
          response.should have_selector("span.age", :content => age.to_s)
          response.should have_selector("span.where", :content => where)
          response.should have_selector("span.category", :content => category)
          response.should have_selector("span.name", :content => name)
        end.should change(Work, :count).by(1)
      end
    end
  end
end


