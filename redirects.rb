module Jekyll

  # STEP 1: Trigger page generation based on redirects.yml
  class RedirectsBuilder < Generator
    safe true
    def generate(site)

      # Get all redirections to work with
      site.data['redirection'].each do |r|

        # Allow for multiple "from" URLS, convert singles into array
        Array(r['from']).each do |from|

          # Create and add redirects to site pages
          new_redirect = RedirectPage.new(
            site,
            site.source,
            from )
          new_redirect.data['permalink'] = from
          new_redirect.data['source_url'] = r['to']
          site.pages << new_redirect

        end # End from Array each

      end # End site.data each

    end # End def generate()
  end # End Builder Class

  # STEP 2: Generate actual page using data from redirects.yml
  class RedirectPage < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'redirect.html')
    end # End initialize

  end # End Page Class
end # End Jekyll
