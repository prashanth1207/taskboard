module Helper 
  def admin
    @admin ||= Admin.create({email: 'admin@gmail.com', username: 'admin', password: 'password',password_confirmation: 'password'})
  end
  def member
    @member ||= Member.create({email: 'member@gmail.com', username: 'member', password: 'password',password_confirmation: 'password'})
  end

  def auth_header_admin
    request.headers['Authorization'] = admin.auth_token
  end

  def auth_header_member
    request.headers['Authorization'] = member.auth_token
  end

  def members(count=2)
    @members ||= begin
      m = []
      count.times do |i|
        m << Member.create({email: "member#{i}@gmail.com", username: "member#{i}", password: 'password',password_confirmation: 'password'})
      end
      m
    end
  end

  def list
    @list ||= admin.created_lists.create(title: 'test title')
  end

  def list_members
    @list_members ||= list.assign_members(members.map(&:id))
  end

  def card(creator = nil)
    creator ||= list_members.last
    @card ||= Card.create(title: 'test card', description: 'test desc', user_id: creator.id, list_id: list.id)
  end

  def cards(creator = nil,numbers = 3)
    @cards ||= begin
      c = []
      creator ||= list_members.last
      numbers.times do |i|
        c << Card.create(title: "Card #{i}", description: "desc of #{i}", user_id: creator.id, list_id: list.id)
      end
      c
    end
  end

  def comment(source, user)
    Comment.create(content: 'my content', commentable_id: source.id, commentable_type: source.class.name, user_id: user.id)
  end
end
