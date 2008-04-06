require File.dirname(__FILE__) + '/../spec_helper'

describe Post do
  it "should have many comments" do
    Post.should_receive(:has_many).with(:comments)
    load 'post.rb'
  end
end

describe Post do
  before(:each) do
    @post = Post.new
  end

  it "should be valid" do
    @post.should be_valid
  end
  
  it "should allow me to add a comment" do
    c = Comment.new
    @post.comments << c
    @post.comments.size.should == 1
    @post.comments[0].should be(c)
  end
  
  it "should save the comment to the database" do
    comment = Comment.new :name => "joe@joe.net"
    @post.comments << comment
    @post.save
    
    post = Post.find(:first)
    post.comments.size.should == 1
  end
  
  it "should replace new lines with <br> when setting body" do
    @post.body = "this has a\nline break"
    @post.body.should == "this has a<br>line break"
  end
  
  it "should find by month and return not nil" do
    @post.title = 'testing 1 2 3'
    @post.body = 'this is a test of the emergency posting system!'
    @post.save
    @post = Post.find_by_date(Date::MONTHNAMES[DateTime.now.month])
    @post.first.should_not be_nil
    @post.first.created_at.month.should == DateTime.now.month
    @post.first.destroy
  end
  
end
