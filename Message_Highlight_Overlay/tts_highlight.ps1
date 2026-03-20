param(
    [string]$Username,
    [string]$Message,
    [string]$OutputFile = "C:\StreamerbotTTS\tts_message.wav"
)

Add-Type -AssemblyName System.Speech

$Username = if ([string]::IsNullOrWhiteSpace($Username)) { "Someone" } else { $Username.Trim() }
$Message  = if ([string]::IsNullOrWhiteSpace($Message))  { "" } else { $Message.Trim() }

if ([string]::IsNullOrWhiteSpace($Message)) {
    exit 0
}

$text = "$Username says, $Message"

$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$synth.Rate = 0
$synth.Volume = 100
$synth.SetOutputToWaveFile($OutputFile)
$synth.Speak($text)
$synth.Dispose()