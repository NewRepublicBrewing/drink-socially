require 'spec_helper'

describe NRB::Untappd::API::Credential do

  let(:app_credential_attrs) { { client_id: 'NewRepublicBrewing', client_secret: 'good_beer' } }
  let(:app_credentials) { NRB::Untappd::API::Credential.new app_credential_attrs }

  let(:user_credential_attrs) { {  access_token: 'brundage' } }
  let(:user_credentials) { NRB::Untappd::API::Credential.new user_credential_attrs }


  context 'initialzation error checking' do

    it 'blows up when creating a credential with no attributes' do
      expect { NRB::Untappd::API::Credential.new }.to raise_error(NRB::Untappd::API::Credential::IncompleteCredentialError)
    end


    it 'blows up when creating a credential with just a client_id' do
      expect { NRB::Untappd::API::Credential.new client_id: 'bmc' }.to raise_error(NRB::Untappd::API::Credential::IncompleteCredentialError)
    end


    it 'blows up when creating a credential with just a client_secret' do
      expect { NRB::Untappd::API::Credential.new client_secret: 'corn' }.to raise_error(NRB::Untappd::API::Credential::IncompleteCredentialError)
    end


    it 'does not raise error for a valid app credential' do
      expect { app_credentials }.not_to raise_error
    end


    it 'does not raise error for a valid user credential' do
      expect { user_credentials }.not_to raise_error
    end

  end


  it 'returns the credentials as a hash' do
    user_credentials.to_h.should eq user_credential_attrs
  end


  shared_examples_for 'has an accessor method' do
    it "makes an accessor method for the accessor" do
      credentials.should respond_to(accessor)
    end
    it "provides the accessor" do
      credentials.send(accessor).should eq attrs[accessor]
    end
  end


  context 'app credentials' do

    let(:attrs) { app_credential_attrs }
    let(:credentials) { app_credentials }

    it_behaves_like 'has an accessor method' do
      let(:accessor) { :client_id }
    end

    it_behaves_like 'has an accessor method' do
      let(:accessor) { :client_secret }
    end

    it 'correctly answers is_app?' do
      credentials.should be_is_app
    end

    it 'correctly answers is_client?' do
      credentials.should be_is_client
    end

    it 'correctly answers is_user?' do
      credentials.should_not be_is_user
    end

  end


  context 'user credentials' do

    let(:attrs) { user_credential_attrs }
    let(:credentials) { user_credentials }

    it_behaves_like 'has an accessor method' do
      let(:accessor) { :access_token }
    end

    it 'correctly answers is_app?' do
      credentials.should_not be_is_app
    end

    it 'correctly answers is_client?' do
      credentials.should_not be_is_client
    end

    it 'correctly answers is_user?' do
      credentials.should be_is_user
    end

  end

end
