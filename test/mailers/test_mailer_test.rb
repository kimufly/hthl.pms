require 'test_helper'

class TestMailerTest < ActionMailer::TestCase
  test "test_smtp" do
    mail = TestMailer.test_smtp
    assert_equal "test smtp", mail.subject
    assert_equal ["system_pms@hthl-tech.com"], mail.to
    assert_equal ["system_pms@hthl-tech.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
