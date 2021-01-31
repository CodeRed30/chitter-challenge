require 'database_helpers'

describe User do
  context '.create' do
    it 'creates a new user' do
      user = User.create(name: 'John Doe', username: 'JohnDoe', email: 'test@example.com', password: 'password123')

      persisted_data = persisted_data(table: :users, id: user.id)

      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first['id']
      expect(user.email).to eq 'test@example.com'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')

      User.create(name: 'John Doe', username: 'JohnDoe', email: 'test@example.com', password: 'password123')
    end
  end

  context '.find' do
    it 'finds a user by ID' do
      user = User.create(name: 'Test', username: 'Testing123', email: 'test@example.com', password: 'password123')
      result = User.find(id: user)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
  end

  context '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.create(name: 'Test', username: 'Testing123', email: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'test@example.com', password: 'password123')

      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil given an incorrect email address' do
      user = User.create(name: 'Test', username: 'Testing123', email: 'test@example.com', password: 'password123')

      expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to be_nil
    end
  end
end