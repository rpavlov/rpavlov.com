xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  sitemap.resources.each do |resource|
    xml.url do
      xml.loc URI.join(config[:host], resource.url)
    end if resource.url !~ config[:ignore_sitemap_regex]
  end
end