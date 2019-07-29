import LiveSocket from "phoenix_live_view"


const channelToken = document.getElementsByTagName('meta')[3].content;
const accessToken = document.getElementsByTagName('meta')[4].content;
console.log("YEET" + JSON.stringify(document.getElementsByTagName('meta')[4].name))

let liveSocket = new LiveSocket("/live", {params: {channel_token: channelToken}});
liveSocket.connect();

let match = document.location.pathname.match(/\/parties\/(\d+)$/);

if(match) {

    let partyId = match[1];
    let channel = liveSocket.channel("event_bus:" + partyId, {});
    channel
    .join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })


    channel.on("playlist_updated", function() {
        console.log("MESSAGE RECEIVED BITCH");
    });


    window.onSpotifyWebPlaybackSDKReady = () => {
        // You can now initialize Spotify.Player and use the SDK
       
        const player = new Spotify.Player({
            name: 'Web Playback SDK Template',
            getOAuthToken: cb => { cb(accessToken); }
          });
        
          // Error handling
          player.on('initialization_error', e => console.error(e));
          player.on('authentication_error', e => console.error(e));
          player.on('account_error', e => console.error(e));
          player.on('playback_error', e => console.error(e));
        
          // Playback status updates
        //   player.on('player_state_changed', state => {
        //     console.log(state)
        //     $('#current-track').attr('src', state.track_window.current_track.album.images[0].url);
        //     $('#current-track-name').text(state.track_window.current_track.name);
        //   });
        
          // Ready
          player.on('ready', data => {
            console.log('Ready with Device ID', data.device_id);
            
            

            channel.on('play', () => {
              //Gets first song uri in playlist and plays it
              let uri = document.querySelector("[name~=song-uri][content]").content;
              if(uri){
                play(data.device_id, uri);
               
                    
        
            }
            });
           
            // Play a track using our new device ID
            //play(data.device_id);
          });

          player.addListener('player_state_changed', (state) => {
         
                   
            if(state.duration - state.position < 100){
              console.log("SONG HAS ENDED");
              channel.push("remove_song", {partyId: partyId});
            }
            console.log(state);
          });
;
         
          // Connect to the player!
          player.connect();
    }
    
}

function getNextSong() {

}

function play(device_id, trackURI) {

    fetch(`https://api.spotify.com/v1/me/player/play?device_id=${device_id}`, {
      method: 'PUT',
      body: JSON.stringify({ uris: [trackURI] }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${accessToken}`
      }
    });
}

