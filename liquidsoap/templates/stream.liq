settings.init.allow_root.set(true)

set("tag.encodings",["UTF-8","ISO-8859-1"])

set("log.file",false)
set("log.level",1)
set("log.stdout",false)
set("log.syslog",true)
set("log.syslog.facility","DAEMON")
set("log.syslog.program","liquidsoap-#{STREAMID}")
set("server.socket",true)
set("server.socket.path","/app/streams/#{STREAMID}.sock")
set("server.socket.permissions",511)

silence = blank(duration=1.)

# This pulls the alpha tag out of the wav file
def append_title(m) =
	[("title",">> Scanning <<")]
end

silence = map_metadata(append_title, silence)

recorder_queue = request.queue()
recorder_queue = server.insert_metadata(id="TXWARN",recorder_queue)

stream = fallback(track_sensitive=false, [recorder_queue, silence])

title = '$(if $(title),"$(title)","...Scanning...")'
stream = rewrite_metadata([("title", title)], stream)

output.icecast(
  %mp3(stereo=false, bitrate=16, samplerate=22050),
  host=HOST,
  port=8000,
  password=PASSWORD,
  genre="Scanner",
  description="Scanner audio",
  mount=MOUNT,
  name=NAME,
  user="source",
  stream
)
