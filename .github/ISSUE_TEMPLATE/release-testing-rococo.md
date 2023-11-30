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
  - [ ] manual flow works
  - [ ] scanning invoice flow works:
      - [ ] with invoice amount
      - [ ] without invoice amount
- [ ] Contact Page:
   - [ ] Adding contact manually works
   - [ ] Add contact with contact qr-code works
   - [ ] Add contact with invoice qr-code works
   - [ ] Endorsing newcomer works
   - [ ] Endorsing a newcomer with reputable works
- [ ] Profile Page
  - [ ] Removing single account works
  - [ ] Add account works:
     - [ ] With import account flow
     - [ ] With create account flow
- [ ] Removing all accounts works
- [ ] Changing communities works.
- [ ] Changing network works
- [ ] Voucher:
   - [ ] Funding Works
   - [ ] Reaping Works

## Meetup Flow
This needs to be tested on rococo, it needs one bootstrapper account and two freshly created accounts, where one will be endorsed, and the other will be a newbie.

- [ ] Registering 1 bootstrappers, 1 endorsee and 1 newbie and performing meetup works. (This needs the rococo single councillor account to call `nextPhase`.)
- [ ] Claiming rewards works
   - [ ] early reward payout in attesting phase
   - [ ] regular reward payout in the next registering phase
- [ ] Registering 1 bootstrapper and two reputables and performing meetup works. (This needs the rococo single councillor account to call `nextPhase`.)
   - [ ] Test that unregistering the reputable refunds the reputation, and the reputable can register again.

## Other
- [ ] inform Slack channel about new release
- [ ] update f-droid branch and create vx.x.x-froid tag
- [ ] verify f-droid has been released
