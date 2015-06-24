class SiteGenerator

  def make_index!
    @beginning_string = "<!DOCTYPE html>
    <html>
      <head>
        <title>Movies</title>
      </head>
      <body>
        <ul>"

    @ending_string = "</ul>
          </body>
        </html>"
    movies = Movie.all
    movies.each do |movie|
      @beginning_string << "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>" 
    end
    @beginning_string << @ending_string
    
    File.open("_site/index.html", 'w') { |file| file.write(@beginning_string) }
  end

  def generate_pages!
    movies = Movie.all
    html = File.read('lib/templates/movie.html.erb')
    content = ERB.new(html)
    make_index!
    movies.each do |movie|
     result =  content.result(binding)
      File.write("_site/movies/#{movie.url}", result)
    end
  end



end