import LiveSocket from "phoenix_live_view"


function play(device_id, trackURI, accessToken) {
  fetch(`https://api.spotify.com/v1/me/player/play?device_id=${device_id}`, {
    method: 'PUT',
    body: JSON.stringify({ uris: [trackURI] }),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${accessToken}`
    }
  });
}


//const channelToken = document.getElementsByTagName('meta')[3].content;

// Checks to make sure client is in a party 
let partyPage = document.location.pathname.match(/\/parties\/(\d+)$/);

if(partyPage) {
  // Retrieves spotifiy access token from html meta data
  const accessToken = document.getElementsByTagName('meta')[3].content;
  
  let data = {};
  let Hooks = {}
  Hooks.PlayButton = {
    mounted(){
      this.el.addEventListener("click", e => {
        let uri = document.querySelector("[name~=song-uri][content]").content;
        if(uri && data.device_id){
          play(data.device_id, uri, accessToken);
        }
      });
    }
  }

  Hooks.PlayList = {
    updated(){
      console.log("PlayList Updated");
    }
  }

  let liveSocket = new LiveSocket("/live",  {hooks: Hooks});
  liveSocket.connect();
  
  // let partyId = partyPage[1];
  // let channel = liveSocket.channel("event_bus:" + partyId, {});
  // channel
  // .join()
  // .receive("ok", resp => { console.log("Joined successfully", resp) })
  // .receive("error", resp => { console.log("Unable to join", resp) })


  // channel.on("playlist_updated", function() {
  //     console.log("MESSAGE RECEIVED BITCH");
  // });


  window.onSpotifyWebPlaybackSDKReady = () => {
    // Initializes Spotify.Player to use the SDK
    const player = new Spotify.Player({
        name: 'Web Playback SDK Template',
        getOAuthToken: cb => { cb(accessToken); }
    });
    
    // Connect to the player!
    player.connect();
    
    // Error handling
    player.on('initialization_error', e => console.error(e));
    player.on('authentication_error', e => console.error(e));
    player.on('account_error', e => console.error(e));
    player.on('playback_error', e => console.error(e));
            
    // Music player is ready to recieve song uris to be played
    player.on('ready', ({ device_id }) => {
      console.log('Ready with Device ID', device_id);
      
      // gives the live view hooks the device_id to use the spotify player
      data.device_id = device_id;
    });

    player.addListener('player_state_changed', ({
      position,
      duration,
      track_window: { current_track }
    }) => {
      console.log('Currently Playing', current_track);
      console.log('Position in Song', position);
      console.log('Duration of Song', duration);
    });
  }   
}

