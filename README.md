# 🎤 Twitch TTS Highlight Overlay (Streamer.bot)

A **real-time Twitch message overlay with Text-To-Speech (TTS)** powered by **Streamer.bot**, **PowerShell**, and a **WebSocket HTML overlay**.

This system:

* Displays user profile, username, and message on screen
* Generates TTS audio dynamically
* Plays the audio through the overlay
* Includes an optional OBS dock view (no audio)

---

## ✨ Features

* 🔊 Windows TTS (natural speech)
* 🧠 Works with Streamer.bot WebSocket
* 🖥️ Clean animated overlay UI
* 📋 OBS Dock view with timestamps
* 🔇 Hidden PowerShell execution (no popups)
* ⚡ Fast & lightweight (no external APIs)

---

## 📁 Folder Structure

```
C:\Program Files\OBS-Studio\Files\Alerts\Message_Highlight_Overlay\
│
├── twitch_tts_overlay.html
├── twitch_tts_dock.html
├── tts_highlight.ps1
├── tts_message.wav (auto-generated)
```

---

## ⚙️ Requirements

* Windows OS
* Streamer.bot (v1.0.4+)
* OBS Studio
* WebSocket enabled in Streamer.bot

---

## 🔧 Setup Guide

### 1. Enable WebSocket in Streamer.bot

* Open Streamer.bot
* Go to **Servers / Clients → WebSocket Server**
* Enable it
* Default: `ws://127.0.0.1:8080`

---

### 2. Add HTML Overlay to OBS

Add a **Browser Source**:

```
file:///C:/Program Files/OBS-Studio/Files/Alerts/Message_Highlight_Overlay/twitch_tts_overlay.html
```

✔ Enable:

* Shutdown source when not visible ❌ (OFF)
* Refresh browser when scene becomes active ❌ (OFF)

---

### 3. Add OBS Dock (Optional)

In OBS:

```
Docks → Custom Browser Docks
```

URL:

```
file:///C:/Program Files/OBS-Studio/Files/Alerts/Message_Highlight_Overlay/twitch_tts_dock.html
```

---

### 4. Add PowerShell Script

Create:

```
tts_highlight.ps1
```

This generates the TTS WAV file.

---

### 5. Create Streamer.bot Action

#### 🔹 Step 1 — C# (Prepare Args)

Imports:

* `showuserprofile`
* `showusername`
* `showusermessage`

Sets:

* `tts_username`
* `tts_message`
* `tts_output_file`

---

#### 🔹 Step 2 — Run PowerShell

Program:

```
powershell.exe
```

Arguments:

```
-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "tts_highlight.ps1" -Username "%tts_username%" -Message "%tts_message%" -OutputFile "%tts_output_file%"
```

---

#### 🔹 Step 3 — C# (Broadcast to Overlay)

Sends JSON via WebSocket:

```json
{
  "type": "custom.twitch.tts",
  "payload": {
    "showuserprofile": "...",
    "showusername": "...",
    "showusermessage": "...",
    "ttsFile": "tts_message.wav"
  }
}
```

---

## 🔊 How It Works

1. Streamer.bot triggers action
2. C# prepares user/message data
3. PowerShell generates `tts_message.wav`
4. C# broadcasts event via WebSocket
5. HTML overlay:

   * Displays message
   * Plays audio file
6. Overlay hides after 20 seconds

---

## 🧪 Testing

In browser console:

```javascript
testTtsOverlay();
```

---

## ⚠️ Important Notes

* ⚠️ Run Streamer.bot as **Administrator**
* 📁 Must have write access to overlay folder
* 🔁 WAV file is overwritten each trigger
* 🎧 OBS must have browser source audio enabled

---

## 🚀 Optional Upgrades

* Queue system (no overlapping TTS)
* Unique WAV filenames per message
* Profanity filter
* Volume control via Streamer.bot
* Voice selection (male/female)
* Emote filtering

---

## 🛠️ Troubleshooting

**No audio playing?**

* Check OBS browser source audio
* Ensure `tts_message.wav` is created
* Verify file path matches HTML

**Overlay not showing?**

* Check WebSocket connection
* Confirm Streamer.bot is running
* Check console (`F12`)

---

## ❤️ Credits

* Streamer.bot
* OBS Studio
* Windows Speech API

---

## 📜 License

Free to use, modify, and share.

  
![Image](https://github.com/MrrZed0/Message_Highlight_Overlay/blob/main/Untitled.png?raw=true)
