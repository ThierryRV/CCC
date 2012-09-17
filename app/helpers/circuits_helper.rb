module CircuitsHelper

  # Returns OpenRunner map for the given id
  def openrunner_map_for(id, options = {w: 500, h: 350, hp: 128, k: 5, m: 0, pa: 1, c: 0, ts: 1346753372})
    return "http://www.openrunner.com/orservice/inorser-script.php?key=mykey&ser=S03&id=#{id}&w=#{options[:w]}&h=#{options[:h]}&hp=#{options[:hp]}&k=#{options[:k]}&;m=#{options[:m]}&pa=#{options[:pa]}&c=#{options[:c]}&ts=#{options[:ts]}"
 end
end
