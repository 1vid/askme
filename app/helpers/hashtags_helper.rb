module HashtagsHelper
  def text_with_hashtag_links(text)
    text&.gsub(Hashtag::HASH_TAG_REGEX) do |hashtag|
      link_to hashtag, hashtag_path(hashtag.delete('#').downcase)
    end
  end
end