# AI Tab Generation Feature - MVP Roadmap (v2)

## Overview
This document outlines the revised implementation plan for AI-powered guitar tab generation, focusing on a progressive, UI-first approach with incremental feature additions. The MVP will start with static tab support and gradually incorporate AI features.

Steps:
1. mp3 file of video is added to video document in firestore
2. create google cloud function that will grab this mp3 file
3. cloud function should analyze the mp3 file and detect musical notes
4. cloud function should turn that into tablature, and create the tabs following best practices from @tab-visual-format.md 
5. those tabs should be added to the ai_tabs collection in firestore, within the section/measures fields of it