part of 'ceremony_test_case.dart';

const _ceremonyTestCases = [ceremonyTestCase1, ceremonyTestCase2];

// Exported as is from the rust-cli
const Map<String, dynamic> ceremonyTestCase1 = {
  'communityCeremony': [
    {'geohash': '0x6476393434', 'digest': '0x2c175151'},
    3,
  ],
  'assignment': {
    'bootstrappersReputables': {'m': 17, 's1': 12, 's2': 4},
    'endorsees': {'m': 7, 's1': 1, 's2': 3},
    'newbies': {'m': 7, 's1': 6, 's2': 4},
    'locations': {'m': 9, 's1': 2, 's2': 7},
  },
  'assignmentCount': {'bootstrappers': 10, 'reputables': 8, 'endorsees': 10, 'newbies': 7},
  'meetupCount': 4,
  'meetups': [
    {
      'index': 1,
      'location': {'lat': '31.2962880000000005509', 'lon': '-54.74528200000000310865'},
      'time': 1647358560000,
      'registrations': [
        [
          '5DMJBbEgLXcmxUDS1EqaqmES4QADMwqRPP4F1rfAktrdt2c9',
          {'index': 2, 'registrationType': 'Reputable'},
        ],
        [
          '5D7YHgBUVxQKZAUQHd9DUp7Q7dm9EbR4zWBCjiqu2efGDuzN',
          {'index': 1, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HbiGQg1mFwg8YCUdYYS3JSpooqdTNF28VBFmPdXhqFKh4tz',
          {'index': 8, 'registrationType': 'Reputable'},
        ],
        [
          '5EtPA6ALAWQJw2MEMcMCPaUZVsa1a34xivMHsbFAx4jpQ1x4',
          {'index': 7, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5DDEUCeVv7jp2qFm47FgUXx18r98tzGA7nRcN9EB2g1PSGbA',
          {'index': 3, 'registrationType': 'Reputable'},
        ],
        [
          '5Fjas4GZUJ9Q6ePTftfLfsBLe79D89ujrr8MPsfVcojms4xD',
          {'index': 2, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HBdsQW2doe38dHyh3n2hVVCxG3RbAXqtrmg6ePDAMxa4uXi',
          {'index': 5, 'registrationType': 'Endorsee'},
        ],
        [
          '5DiCgaczypwmFVNEFawWLqyUCTn5i42NQRbaQWnMeN8d5q9V',
          {'index': 2, 'registrationType': 'Endorsee'},
        ],
        [
          '5ECgUyyhbjpzw2XzXyMz3owTG7GGBmHsNRp4o753baebpwWh',
          {'index': 9, 'registrationType': 'Endorsee'},
        ],
        [
          '5GH95V5433abDV2TL61XqBMyM7JE7VDkYcrNWyJP5pPjJNHz',
          {'index': 5, 'registrationType': 'Newbie'},
        ],
        [
          '5CFNV4qYF22DLEffn1tnyHtHohrEXQmBsVJtWcMSzH7fS2C1',
          {'index': 1, 'registrationType': 'Newbie'},
        ]
      ],
    },
    {
      'index': 2,
      'location': {'lat': '31.2962880000000005509', 'lon': '-54.7242719999999991387'},
      'time': 1647358560000,
      'registrations': [
        [
          '5FLgx9bNsX4ZoJQ4hg1QV98y8LwSd48p8nQusWT8u97eFyFW',
          {'index': 5, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5GYMEKk6mtEExCVwEzu4GPFCvb3tDePNryv4d1bHg6UJnwdS',
          {'index': 1, 'registrationType': 'Reputable'},
        ],
        [
          '5Cz3h58y9k92YKPfSL84LmMzvhgS2eVysjgKznZ1qEhAgMN7',
          {'index': 7, 'registrationType': 'Reputable'},
        ],
        [
          '5HEAUd6wMDDmK5sVvG9BWVj2Ej2XSZgEpCr7LGBLGRpo3wti',
          {'index': 6, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5EhvAkh6TYvGqNxEFULzZYo9unwFrka4GhPby83PuS3xxUhg',
          {'index': 6, 'registrationType': 'Endorsee'},
        ],
        [
          '5EsoqMe9ZZhGKeTugAVJL3oVXyY5daFAVaczLRUGVZ1munFs',
          {'index': 3, 'registrationType': 'Endorsee'},
        ],
        [
          '5HbsbWfYWuMaoytYXrfVNsHXavr5wAev8HqC4yBEfmzxeapC',
          {'index': 10, 'registrationType': 'Endorsee'},
        ],
        [
          '5GumUzWFr7wx9btS3UYHJQTkUNTZfgKEbxBipKSbkZ23Nsak',
          {'index': 4, 'registrationType': 'Newbie'},
        ],
        [
          '5ECnkPCrFEvrkfcPZ7qw3Srrh7XYkKQXLKk97zJLBrJYH9rS',
          {'index': 7, 'registrationType': 'Newbie'},
        ]
      ],
    },
    {
      'index': 3,
      'location': {'lat': '31.3053069999999991069', 'lon': '-54.7347770000000011237'},
      'time': 1647358560000,
      'registrations': [
        [
          '5Hbpnh7BmpgD5fEWvhXKus9ZNDsHNFKkwuThn7ZJHuXHUbuj',
          {'index': 5, 'registrationType': 'Reputable'},
        ],
        [
          '5CmEECZepMv2CDiXT44jmQuDxfv9GcjKJuBd6EwCEhBY7hUk',
          {'index': 4, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5He82NUxbEkzwoiqvmPGCrbSWDVtJXtg9VcF6GRs4yJFM7R1',
          {'index': 10, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5EngbYkE7dLJrp1a3wTpdMJXCZr1pKWUY4pNfCVT4PkMC8u5',
          {'index': 6, 'registrationType': 'Reputable'},
        ],
        [
          '5H3m7voDdXMbCxfgETYvhcy4N15upcZ7YEvQi9w4QmNvFifh',
          {'index': 7, 'registrationType': 'Endorsee'},
        ],
        [
          '5E2fnjYfPrtcH6DqExDGTcsMzZ4ogpLvsJ9q8raoQic1WC3K',
          {'index': 4, 'registrationType': 'Endorsee'},
        ],
        [
          '5HpQ6hNCx4RUWTYsnh4hG4QLqQeADHqHVFxEtrmMyr3ykrvy',
          {'index': 3, 'registrationType': 'Newbie'},
        ],
        [
          '5CM2xmTJcwU4ebTbzjGZYAaW1btqH83C8m2sE7irKmcV8jH2',
          {'index': 6, 'registrationType': 'Newbie'},
        ]
      ],
    },
    {
      'index': 4,
      'location': {'lat': '31.31432600000000121554', 'lon': '-54.74528200000000310865'},
      'time': 1647358560000,
      'registrations': [
        [
          '5DCLyStXJFxAaUCdaWLCEUgGmnRY3mY9RgHNiwYyvxpQyVdn',
          {'index': 8, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HRFE7m8pqozZ39xSSWGtq9qcnn6qYqEFLV5AN7tURzbckDG',
          {'index': 4, 'registrationType': 'Reputable'},
        ],
        [
          '5FCQhQAbnzGnnDpqhgZP1XUmymQnsb5Xw6sJXHFjeyihB4u8',
          {'index': 3, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5FX4dWmZ4xNPiV1i7AsmjXZzEdP2dCPxT88wt3A1gjyo3Tpv',
          {'index': 9, 'registrationType': 'Bootstrapper'},
        ],
        [
          '5HQPCokWX9PhV6NmSv54TwwF4wGe1qi7qwoV9j592eWVmzbZ',
          {'index': 1, 'registrationType': 'Endorsee'},
        ],
        [
          '5D87QaJWQKdo2FReKWRK9GTaPwt3JH48ZLhrQqKP61iMSf6G',
          {'index': 8, 'registrationType': 'Endorsee'},
        ],
        [
          '5GYquk1ZS8ZhydK7XGsnzyQcGaoSFVQKZ53wNCwySc4hPLwT',
          {'index': 2, 'registrationType': 'Newbie'},
        ]
      ],
    }
  ],
};

const Map<String, dynamic> ceremonyTestCase2 = {
  'communityCeremony': [
    {
      'geohash': '0x65356e3167',
      'digest': '0x4b07dbb2',
    },
    3,
  ],
  'assignment': {
    'bootstrappersReputables': {
      'm': 19,
      's1': 3,
      's2': 2,
    },
    'endorsees': {
      'm': 7,
      's1': 2,
      's2': 6,
    },
    'newbies': {
      'm': 5,
      's1': 4,
      's2': 1,
    },
    'locations': {
      'm': 9,
      's1': 4,
      's2': 7,
    },
  },
  'assignmentCount': {
    'bootstrappers': 10,
    'reputables': 12,
    'endorsees': 10,
    'newbies': 5,
  },
  'meetupCount': 4,
  'meetups': [
    {
      'index': 1,
      'location': {
        'lat': '17.1982479999999995357',
        'lon': '-36.404029999999998779',
      },
      'time': 1647440640000,
      'registrations': [
        [
          '5C7Ld5f35gB9qeM6fL9hnvLZDi318NnoCNY3CDPyLK3jRoR2',
          {
            'index': 3,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5FZKa8Ka8nA7RW6KvS4EJTu1QaZ9VSsXa84CHMNpG8V4igMJ',
          {
            'index': 8,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5HQoc7aw3XJkHjUGBXrkTdQVJLnXNAHFjyewcgRXYSBtDN6E',
          {
            'index': 3,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5Gc9NmspyKvaq6ZADTREHcxWmTmGA1tmUXQAwXfUX9Pu1jur',
          {
            'index': 12,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5FYhQxvUZSzZVkK1PHZHjN4gYbteLDu2HMayhsTYDtxcyv69',
          {
            'index': 7,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5GnQsfomVxZNGRMFAhBmUBvSHrn9nWVK35L6hPC59hdVQwjg',
          {
            'index': 2,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5CLyFP4kzofe76zaTjqsuypXroBKcWKSoUxbgC1paYuoQ62n',
          {
            'index': 5,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5GWapdkqpoyYnkWxACPhvjtGQ3a1PeYVMKWicwhJBPabi9rt',
          {
            'index': 7,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5EHfSx1bkY6cD6eNyEVxemxEvC5qbucnq81RoQVazrn4yH81',
          {
            'index': 2,
            'registrationType': 'Newbie',
          }
        ],
        [
          '5GhTiW4vEUJNbcLK4KU9TSJJ5UHgx7FCpFfDyJgLtTBYSzst',
          {
            'index': 3,
            'registrationType': 'Newbie',
          }
        ]
      ],
    },
    {
      'index': 2,
      'location': {
        'lat': '17.2163199999999996237',
        'lon': '-36.4228340000000017085',
      },
      'time': 1647440640000,
      'registrations': [
        [
          '5Evu8VX12Qb6i3czcAL5w7bN9hMHzatPGyBMM7bm2NeeZtGM',
          {
            'index': 7,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5E1cE1R9hyLFdWD76tpvoEJ5zYsApir5zMMf45z4Worg2mtX',
          {
            'index': 2,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5DFezoADVsifFxb4PowHpWVxWKTvMCGXjqtbBrfFQsFLxHtd',
          {
            'index': 11,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5D2SGcNubDG2mzcJ5nz39tfiw3okskuJJL9sky2yiE2Kh2Af',
          {
            'index': 6,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5DPwdMpdcc3dARi65AEeCN7kHozbveL51nAKyf42ug3GHbKY',
          {
            'index': 1,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5EhavKo6zWtmCZ6WGTRqFy2NXG6iqgq5bXvZ8UZtd2sBi3Ru',
          {
            'index': 6,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5Dnc6mpUjm3tq3ZdLP5RhMd3Jxx2cK6VwP6DKfsttVRkRD1e',
          {
            'index': 2,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5Dkvebnhxcbr6Ya4ryaYbHvpjMhG6AA8ih5Co47YmFLx7mvx',
          {
            'index': 9,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5C5o7mk1x7gzrD2zh9dAb674TFZV4tcys39cVsEQadp6Y56y',
          {
            'index': 4,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5Dxt8z5EVUbYtQHMwPYhhEvR1h6c9qXyUhDiXRjz4NqWDx9K',
          {
            'index': 1,
            'registrationType': 'Newbie',
          }
        ]
      ],
    },
    {
      'index': 3,
      'location': {
        'lat': '17.1982479999999995357',
        'lon': '-36.41343200000000024374',
      },
      'time': 1647440640000,
      'registrations': [
        [
          '5Gn4NccWrvD8FksdcXDYjAmyAfHNWXT6JBRtwWXP8F2pZPL8',
          {
            'index': 1,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5Ge8p6pRNPddZhboL6XnH5osxcZnjuiwY64rSBF7Vn52RexR',
          {
            'index': 10,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5E2ZjsXNBV38vZqQnzgAPQRC8qNTfGnTJTSJ1LSuaHaLBJ7P',
          {
            'index': 5,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5DS2LxnjR5DWpam9HNR3oXguubUxtntU4kaeTYVhGX6oXQZv',
          {
            'index': 10,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5ELvL4yTTG9aTDpzwsZ14YAUcSkeQnmnqaeh1RBXCKJcCdwU',
          {
            'index': 5,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5DqgmJMhmsh4CZMYE77b8KtSmxnnvNfUSycj4uwi6QzNid15',
          {
            'index': 9,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5HppERSy15s2FPxFq8b8d6gnBXZr4XYfzLmV7cdmtweATW3m',
          {
            'index': 6,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5FZoHKFUVYzkMqidjhAEHygyFBGPucKkyCsNkKvNkzLcjpRN',
          {
            'index': 1,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5DDKzPPwcDtNhS2TtX1msGEqm5M74BMm2DEmhtkZQbgumbzp',
          {
            'index': 8,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5DMCpBVE5Az4QBhyAaGCXAjFnvj9FhE5R7jDPdH5V3apP7eg',
          {
            'index': 5,
            'registrationType': 'Newbie',
          }
        ]
      ],
    },
    {
      'index': 4,
      'location': {
        'lat': '17.20728400000000135606',
        'lon': '-36.404029999999998779',
      },
      'time': 1647440640000,
      'registrations': [
        [
          '5Ec2zY9zJeZSVKFUQzKz1fBQHyaaoypiVdhpnmadsTLtFaHU',
          {
            'index': 4,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5FhFozMr9NidBjnZYXxYfZCBDomwEpekZLJk9NVipCd5UPBj',
          {
            'index': 9,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5EbbkGR1hzyNkYpcWaMUuUNw5wANF1uCgMhWAMNACDkLqgmU',
          {
            'index': 4,
            'registrationType': 'Bootstrapper',
          }
        ],
        [
          '5HQHcSD6Xc2nF88XKDcrZSfMiQWE3VQWMMri5Kgk1vQWRqzo',
          {
            'index': 8,
            'registrationType': 'Reputable',
          }
        ],
        [
          '5CQ5y1w6zxKkBoCkoYJGEojHUvzmG9V5mdwKLgQUjyq1Ynnq',
          {
            'index': 3,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5HGwKmbmvCijjHGik3FC26XTEJCZej16DBnDxEpBHeNaiQqT',
          {
            'index': 10,
            'registrationType': 'Endorsee',
          }
        ],
        [
          '5Hn1cBunJQX3kBonZJRyRAm35hWJFPyjK7gTiTkByG4gZ4vz',
          {
            'index': 4,
            'registrationType': 'Newbie',
          }
        ]
      ],
    }
  ],
};
