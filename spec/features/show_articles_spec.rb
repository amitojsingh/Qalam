require "rails_helper"

RSpec.feature "Showing an article" do

	before do
		@john=User.create(email: "john@gmail.com",password: "password")
		@faiz=User.create(email: "faiz@gamil.com",password:"123456")
		@article=Article.create(title: "Title of the article", body: "BOdy of the article",user: @john)
	end

	scenario "not signed in user hide edit and delete button" do
		visit "/"

		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")
		expect(current_path).to eq(article_path(@article))
end

scenario "to not-owner signed in user show edit and delete button" do

 login_as(@faiz)
	visit "/"


	click_link @article.title

	expect(page).to have_content(@article.title)
	expect(page).to have_content(@article.body)
	expect(page).not_to have_link("Edit Article")
	expect(page).not_to have_link("Delete Article")
	expect(current_path).to eq(article_path(@article))
end
scenario "to owner signed in user show edit and delete button" do

 login_as(@john)
	visit "/"


	click_link @article.title

	expect(page).to have_content(@article.title)
	expect(page).to have_content(@article.body)
	expect(page).to have_link("Edit Article")
	expect(page).to have_link("Delete Article")
	expect(current_path).to eq(article_path(@article))
end
end
