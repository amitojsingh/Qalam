require 'rails_helper'

RSpec.feature "Adding comments to articles" do

  before do
    @john=User.create(email: "john@example.com", password:"123456")
    @fred=User.create(email: "fred@example.com", password: "123456")
    @article1=Article.create(title: "Title",body: "Body", user: @john)
    login_as(@fred)
  end

  scenario "Permits a signed in user to write comment" do
  visit "/"

  click_link @article1.title
  fill_in "New comment", with: "peeeeekaaaboooo"
  click_button "Add Comment"

  expect(page).to have_content("Comment has been created")
  expect(page).to have_content("peeeeekaaaboooo")
  expect(current_path).to eq(articles_path(@article1.id))
end
end
