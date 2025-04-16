require "test_helper"

class BlogPostTest < ActiveSupport::TestCase
  test "draft? returns true for draft blog post" do
    blog_posts(:draft).tap do |post|
      assert post.draft?
    end
  end

  test "draft? returns false for published blog post" do
    BlogPost.new(published_at: 1.year.ago).tap do |post|
      refute post.draft?
    end
  end
  test "published? returns false for draft blog post" do
    blog_posts(:draft).tap do |post|
      assert_not post.published?
    end
  end

  test "scheduled? returns true for scheduled blog post" do
    blog_posts(:scheduled).tap do |post|
      assert post.scheduled?
    end
  end

  test "scheduled? returns false for published blog post" do
    blog_posts(:published).tap do |post|
      assert_not post.scheduled?
    end
  end

  test "scheduled? returns false for draft blog post" do
    blog_posts(:draft).tap do |post|
      assert_not post.scheduled?
    end
  end

  test "validations" do
    post = BlogPost.create(title: "", body: "")
    assert_not post.valid?
    assert_includes post.errors[:title], "can't be blank"
    assert_includes post.errors[:body], "can't be blank"

    post.title = "Valid Title"
    post.body = "Valid body content."
    assert post.valid?
  end

  test "scopes" do
    draft_post = BlogPost.create(title: "Draft Post", body: "Draft content.", published_at: nil)
    published_post = BlogPost.create(title: "Published Post", body: "Published content.", published_at: Time.current)
    scheduled_post = BlogPost.create(title: "Scheduled Post", body: "Scheduled content.", published_at: Time.current + 1.day)

    assert_includes BlogPost.draft, draft_post
    assert_includes BlogPost.published, published_post
    assert_includes BlogPost.scheduled, scheduled_post

    assert_not_includes BlogPost.draft, published_post
    assert_not_includes BlogPost.draft, scheduled_post
  end
end
