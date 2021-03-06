# encoding: utf-8
require 'spec_helper'

describe "User pages" do

  subject { page }

  shared_examples_for "all user pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Suivre"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Suivre"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Suivre" }
          it { should have_selector('input', value: 'Ne plus suivre') }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Ne plus suivre"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Ne plus suivre"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Ne plus suivre" }
          it { should have_selector('input', value: 'Suivre') }
        end
      end
    end

  end

  describe "signup page" do
    before { visit signup_path }
    let(:heading)    { "S'inscrire" }
    let(:page_title) { "Inscription" }

    it_should_behave_like "all user pages"
  end

  describe "signup" do

    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Créer mon compte" }.not_to change(User, :count)
      end

      describe "error messages" do
        before { click_button "Créer mon compte" }

        it { should have_selector('title', text: "Inscription") }
        it { should have_content('error') }
      end

   end

    describe "with valid information" do
      before do
        fill_in "Nom",                          with: "Example User"
        fill_in "Email",                        with: "user@example.com"
        fill_in "Mot de passe",                 with: "foobar"
        fill_in "Confirmation du mot de passe", with: "foobar"
      end

      it "should create a user" do
        expect do
          click_button "Créer mon compte"
        end.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "Créer mon compte" }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenue') }
        it { should have_link('Se déconnecter') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Modification de votre profil") }
      it { should have_selector('title', text: "Modification du profil cyclo.") }
      it { should have_link('Changer', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Enregister" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nom",                          with: new_name
        fill_in "Email",                        with: new_email
        fill_in "Mot de passe",                 with: user.password
        fill_in "Confirmation du mot de passe", with: user.password
        click_button "Enregister"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Se déconnecter', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'Liste de tous les cyclos') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        it { should have_link('Supprimer', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('Supprimer') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('Supprimer', href: user_path(admin)) }
      end
    end

  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_selector('title', text: full_title('Vous suivez')) }
      it { should have_selector('h3', text: 'Vous suivez') }
      it { should have_link(other_user.name, href: user_path(other_user)) }

    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end
      it { should have_selector('title', text: full_title('Ils vous suivent')) }
      it { should have_selector('h3', text: 'Ils vous suivent') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
end
