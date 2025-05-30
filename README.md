# Multilingual-Handwriting-System-for-Visually-Impaired-People

## 🧠 Abstract

This project introduces an intelligent **multilingual examination and learning platform for visually impaired individuals**, enabling autonomous exam participation and emotional engagement tracking.

The system:
- Reads questions aloud via **Text-to-Speech (TTS)**
- Records and transcribes **verbal answers** via **Speech Recognition**
- Detects **user emotions** via facial analysis
- Plays motivational or topic-related **videos in the user's native language** if sadness or sleepiness is detected

By combining **multilingual support** and **emotion awareness**, this system fosters inclusive, independent, and emotionally supportive education for visually impaired learners.

---

## 🚀 Features

- 🎤 Speech recognition with error correction
- 🔊 Text-to-speech output in native languages
- 🧠 Emotion detection through facial analysis
- 📹 Emotion-based motivational/educational video playback
- 🎓 GUI-based hands-free exam system
- 🌐 Multilingual content support
- 📈 Audio signal analysis (time and frequency domain)
- 👩‍🏫 Personalized feedback and adaptive learning

---

## 🏗️ System Modules

### 1. Speech Recognition and Text Conversion
Captures the user’s voice and converts it into text using advanced models (e.g., **Wav2Vec 2.0** + Google Speech-to-Text API) with noise cancellation and accent adaptation.

### 2. Audio Analysis Module
Analyzes audio quality using **MATLAB** for waveform and frequency plots to ensure clean inputs for transcription.

### 3. Text-to-Speech (TTS) Module
Uses **Microsoft Speech API (SAPI)** to read questions or instructions aloud in multiple voices/languages.

### 4. Exam Flow and Management Module
Controls exam progression: loads questions, records answers, handles GUI transitions, and saves responses.

### 5. Emotion-Based Native Video Module
Detects emotional states (sad, sleepy) and plays motivational/educational videos using **MATLAB GUI and ActiveX controls**, adapting based on the user's emotional feedback.

---

## 🖥️ System Architecture

```text
+-----------+        +--------------------+        +-----------------+
| Microphone| -----> | Speech Recognition | -----> | Transcribed Text|
+-----------+        +--------------------+        +-----------------+
       |                                                  ↑
       |       +---------------------+           +------------------+
       +-----> | Audio Analysis (MATLAB) | <-----| Audio Signal     |
               +---------------------+           +------------------+

+------------------+         +-------------------+
| TTS Output       |<--------| Exam Question Text|
+------------------+         +-------------------+

+-----------------------------+
| Emotion Detection (GUI/ML) |
+-----------------------------+
           ↓
+------------------------------+
| Motivational/Topic Video TTS |
+------------------------------+
```

---

## ⚙️ System Requirements

### 🔧 Hardware
- Microphone & Speakers (built-in or external)
- Dual-core processor or better
- Minimum 4GB RAM
- Stable internet connection

### 💻 Software
- OS: Windows 10/11
- Languages: **Python**, **MATLAB R2021b+**
- Libraries/Tools:
  - Google Speech-to-Text API
  - Microsoft SAPI
  - Python NLP: `NLTK`, `spaCy`, or `Transformers`
  - OpenCV for face detection
  - ActiveX for media control

---

## 🔧 Installation & Setup

> Ensure Python and MATLAB R2021b (or later) are installed before proceeding.

### 1. Clone the Repository
```bash
git clone https://github.com/Srinidhi2507/Multilingual-Handwriting-System.git
cd Multilingual-Handwriting-System
```

### 2. Install Python Dependencies
```bash
pip install -r requirements.txt
```

### 3. Launch Modules
- Open MATLAB and copy the path.
- Run modules using the script name.
- SMART_SYSTEM_GUI - Examination module
- E_Learning - Learning module

---

## 🧪 How to Use

1. Launch the GUI exam module.
2. The system reads each question aloud.
3. The user responds verbally; the system records and transcribes the response.
4. The learning module plays videos based on keys.
5. The system monitors emotional states via webcam.
6. If sadness/sleepiness is detected, an alternate or motivational video is played in the user's native language.
7. Exam responses are saved and reviewed.

---

## 📸 Screenshots


- Speech recognition GUI
  ![image](https://github.com/user-attachments/assets/28f25606-f774-4bdc-83ae-14908d485968)

- Emotion detection interface
  ![image](https://github.com/user-attachments/assets/fe3eed04-986d-4a19-83a6-0d0763fc57aa)

- Audio waveform/frequency spectrum in MATLAB
  ![image](https://github.com/user-attachments/assets/9e5f754b-ff21-4440-ac2d-840a0be8b6bd)

- Video playback interface
  ![image](https://github.com/user-attachments/assets/fd897596-2310-446e-8f1c-960d6aa8d246)


---

## 📚 References

- IEEE papers and research on TTS, speech recognition, and emotional computing (full list in presentation)

---

## 🔒 License

This project is for academic use. For reuse or commercial adaptation, please contact the project team.

---

## 🌟 Acknowledgements

Special thanks to the faculty of Panimalar Institute of Technology for their support and mentorship throughout this project.

---
