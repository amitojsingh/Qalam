require 'rails_helper'

RSpec.feature " Editting an article" do
	before do
		@john=User.create(email: "john@example.com",password: "password")
		login_as(@john)

		@article= Article.create(title: "Title", body: "body",user: @john)
	end
	scenario " A user updates an article" do
		visit "/"
		click_link @article.title

		click_link "Edit Article"

		fill_in "Title", with: "updated Title"
		fill_in "Body", with: "updated body of Article"
		click_button "Update Article"

		expect(page).to have_content("Article has been updated")
		expect(page.current_path).to eq(article_path(@article))
	end
scenario " A user fails to updates an article" do
		visit "/"
		click_link @article.title

		click_link "Edit Article"

		fill_in "Title", with: ""
		fill_in "Body", with: "updated body of Article"
		click_button "Update Article"

		expect(page).to have_content("Article has not been updated")
		expect(page.current_path).to eq(article_path(@article))
	end
end
