<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
   <url>
      <loc><%= @host %></loc>
   </url>
  
   <% @steps.each do |step| %>
     <url>
        <loc><%= "#{@host}/registrations/#{step}" %></loc>
     </url>
   <% end %>
</urlset>