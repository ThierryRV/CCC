racine = File.expand_path("../../public/documents", __FILE__)
Dir.foreach(racine) do |dirNameLoop|
    if (!dirNameLoop.nil? && dirNameLoop != "." && dirNameLoop != ".." )
        dirName = "#{racine}/#{dirNameLoop}"
				puts "#{dirName}"
    end
end
