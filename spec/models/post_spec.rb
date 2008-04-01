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
  
end
