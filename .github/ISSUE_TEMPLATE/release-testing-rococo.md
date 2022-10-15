---
name: Release Testing Rococo
about: Manual Release testing tasks before doing a release
title: Release testing <enter-version>
labels: ''
assignees: ''

---

Tested on commit <enter-commit>

## General
- [ ] Onboarding
   - [ ] Import account flow works
   - [ ] Creating account flow works

- [ ] Qr-Scan from home page:
   - [ ] Scanning Contact navigates to contact and importing contact works
   - [ ] Scanning Invoice navigates to send flow and send works:
       - [ ] with invoice amount
       - [ ] without invoice amount
- [ ] Send flow:
  -  [ ] manual flow works
  - [ ] scanning invoice flow works:
      - [ ] with invoice amount
      - [ ] without invoice amount
- [ ] Add contact flow:
   - [ ] Adding contact manually works
   - [ ] Add contact with contact qr-code works
   - [ ] Add contact with invoice qr-code works
- [ ] Profile Page
  - [ ] Add account works:
     - [ ] With import account flow
     - [ ] With create account flow
- [ ] Removing all accounts works

## Meetup Flow
This needs two bootstrappers on a rococo test community, and preferably three smartphones to streamline the process.

- [ ] Registering 2 bootstrappers and 1 newbie and performing meetup works. (This needs the rococo single councillor account to call next phase.)
- [ ] Claiming rewards works (currently only possible in registering phase from the app side)
- [ ] Registering 2 bootstrappers and a reputable and performing meetup works. (This needs the rococo single councillor account to call next phase.)
