var modules = [
  'http://cslearning.gov.uk/modules/OhOenB-NSO6IDKiiZ3yfqw', // Doing the right thing
  'http://cslearning.gov.uk/modules/8GNqDxs5S1GUWi2MYa4-Vg', // Inclusion and diversity in assessment 
  'http://cslearning.gov.uk/modules/W6YFRHC9R_ejbQaTFUbtLQ', // Match the method
  'http://cslearning.gov.uk/modules/EuDDcYcfQIKx0epJzJ8IVQ', // Forecasting: foundations
  'http://cslearning.gov.uk/modules/VEFE3S2OQd-VCgN3b8tJ8A', // Forecasting: Tools, techniques and case studies
  'http://cslearning.gov.uk/modules/FNaEfuj1Rc-MBV-ZhZ5ACw', // Forecasting: soft skills
  'http://cslearning.gov.uk/modules/inDw4azCTpyDtptdcRr7gg', // Founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/UZxNIsKBRheiHPKUpPmluA', // European law and its institutions
  'http://cslearning.gov.uk/modules/5bb5SEzaRN6LAPksiZ7ygQ', // Policies, responsibilities and finance
  'http://cslearning.gov.uk/modules/CgmX8vhcRhiV4gfcmraCGg', // EU external relations
  'http://cslearning.gov.uk/modules/AGao8tqSRrmAMDyc1YTb9w', // backlog
  'http://cslearning.gov.uk/modules/xUiItUonQLi_FA8l3bqKHQ', // Stress management
  'http://cslearning.gov.uk/modules/Jx_9dwwdTRKJ_SFt4SposQ', // Diversity and Inclusion Test
  'http://cslearning.gov.uk/modules/LItXcCzzT72t4An4aUO85w', // Test
  'http://cslearning.gov.uk/modules/ipRhbQgkQ5aphCdyh84Nsw', // topic 1
  'http://cslearning.gov.uk/modules/VH2vOcCmSQOKOzohhZxIAg', // module 1 short name
  'http://cslearning.gov.uk/modules/ZLn805PYRJ-LTxHvKcTlJw', // Testing if a SCORM will upload
  'http://cslearning.gov.uk/modules/ZCnLwB_nTnySNFb6P93PkA', // test D&I SCORM
  'http://cslearning.gov.uk/modules/NLjILWg7R2Oykps7c4YBvw', // Tutorial 1: Founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/okgKbxPhSQicJmZoTcDIUA', // Tutorial 2: European law and institutions
  'http://cslearning.gov.uk/modules/MX7V2vzMTjCvujNjMbvTfQ', // Tutorial 3: Responsibilities and finance
  'http://cslearning.gov.uk/modules/77SXyYIdT7mGGpe8qHFinA', // Tutorial 4: EU external relations 
  'http://cslearning.gov.uk/modules/p1pxq7bJSK20Y9YvS2sqnA', // Diversity and Inclusion introducing Unconscious Bias
  'http://cslearning.gov.uk/modules/MDP-cqraQBafT3af2mXppg', // test module
  'http://cslearning.gov.uk/modules/_B95ItrrTIG2WC6eHgq6RA', // What's the question?
  'http://cslearning.gov.uk/modules/VKH_z628TvSWpdgCCLTVuQ', // Government Security Classifications Test
  'http://cslearning.gov.uk/modules/-alnU9YdTVySbiP7LCrSmg', // Government Security Classifications (Not test)
  'http://cslearning.gov.uk/modules/i94OEquqQyOA1NIVYPw23g', // Protecting and sharing information
  'http://cslearning.gov.uk/modules/SQGcKLG0S9OeIejc-IquaQ', // In the workplace
  'http://cslearning.gov.uk/modules/pi4hf7M7Rsms73FXx2HPOg', // Working flexibly
  'http://cslearning.gov.uk/modules/xA5dyiPEREieJJ4KsGGzmw', // Staying safe online
  'http://cslearning.gov.uk/modules/hmwBfdCrRw2ALBazsa2uNg', // Fraud
  'http://cslearning.gov.uk/modules/TJaNQR26RSuLT5gWWrRJxg', // Managing information as an asset
  'http://cslearning.gov.uk/modules/VAID8CVER-m_BytqJkz9eQ', // Different team types
  'http://cslearning.gov.uk/modules/YlhQZa57RnCDgdn_pIGvWQ', // The performance management system
  'http://cslearning.gov.uk/modules/rA642T_ORw2AJoD8nlHBBQ', // Being a performance manager
  'http://cslearning.gov.uk/modules/tZJDANWwTimJTxNVwffQfQ', // Managing dips in performance
  'http://cslearning.gov.uk/modules/1gfwac-_RwKunaKS2r5esw', // Online scenario: The first conversation
  'http://cslearning.gov.uk/modules/Lkhk6iyTQWqMV1r-vEnIEg', // Online scenario: The follow-up conversation
  'http://cslearning.gov.uk/modules/QwX9cFfZSmmsI9_C5DBkbA', // Developing people: assessing development needs
  'http://cslearning.gov.uk/modules/y0-OSI86TvSOedU5yc_CVQ', // Developing people: discussing development needs
  'http://cslearning.gov.uk/modules/MNH5go5SSemdQgIOSX9fxQ', // Developing people: development activities
  'http://cslearning.gov.uk/modules/zUwqIEviR5G7LnBvhe98-g', // Developing people: supporting development
  'http://cslearning.gov.uk/modules/bDtPfpM-SkWLJ3bOZYVApg', // Developing people: meaning of people development
  'http://cslearning.gov.uk/modules/migHKaO8ToS4asAR1zsxGw', // Developing people: scenarios
  'http://cslearning.gov.uk/modules/4abyfRkGSJ6B6GqOusPXeg', //  Challenges when writing
  'http://cslearning.gov.uk/modules/t2BaPmxKTamC3BIfnAyDIQ', //  How did your customer react to what you wrote? 
  'http://cslearning.gov.uk/modules/HOkIyGYWTLqjvf87F3QUgg', // Risky business: mythbuster
  'http://cslearning.gov.uk/modules/EIgOo-P-TxyjTSBen-3ENg', // What is risk?
  'http://cslearning.gov.uk/modules/jgTOfRpXTGy6CUMKh22_4w', // Prioritising risk
  'http://cslearning.gov.uk/modules/NXxtvQsjRSyO7Zmk6765hg', // Managing issues
  'http://cslearning.gov.uk/modules/sfHJjI2zSKm2SSnMFV9luA', // Keeping track
  'http://cslearning.gov.uk/modules/fkRWw6FtSQGi5aQyAaRMGw', // Test your knowledge
  'http://cslearning.gov.uk/modules/dc3oUlOqTjmOPqx7mSrw9w', // Why focus on outcomes and benefits?
  'http://cslearning.gov.uk/modules/I4ZPChj7QX6JiAU12HqeqQ', //  Keeping your eye on outcomes and benefits
  'http://cslearning.gov.uk/modules/4DTZApG9QSWfdE_a_frH6Q', // Outcomes and benefits: check your knowledge
  'http://cslearning.gov.uk/modules/SDD-fF3zScekq_SSMymt3Q', // Getting started
  'http://cslearning.gov.uk/modules/jR0SgMp-TjOeRVgImi-Daw', // Attending a stand-up
  'http://cslearning.gov.uk/modules/gdvw0TCxR8Wn0lwXhvbmNw', // The backlog
  'http://cslearning.gov.uk/modules/lyUpP85HQXGZ7qJTe9Fabw', // The show and tell
  'http://cslearning.gov.uk/modules/imQVVii8Tje3zc5RrcAPnQ', // Attending a retrospective
  'http://cslearning.gov.uk/modules/1dwbyciAQ-ay8RJHnh5gFw', // Tutorial 1: Founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/3m2lpbzdQc2hMBBNQUnwsQ', // Tutorial 2: European law and institutions
  'http://cslearning.gov.uk/modules/RywZ9FVfTiiqcDtELMLmFg', // Tutorial 3: Responsibilities and finance
  'http://cslearning.gov.uk/modules/usFLW4qQQX2rOppm_5lV1g', // Tutorial 4: EU external relations
  'http://cslearning.gov.uk/modules/WfBiZ5EBR-StlSMk2hS-lg', // Annual report and accounts and financial information 
  'http://cslearning.gov.uk/modules/8wK-eJU4R9ysAduzDrA8Fw', // Importance of accounting standards
  'http://cslearning.gov.uk/modules/DMCUF8KfT-aBL1rG4S4bnA', // Transactional finance and link to commercial process
  'http://cslearning.gov.uk/modules/PQqHYBGZQfyjntoaX7SfRw', // Knowledge check
  'http://cslearning.gov.uk/modules/7rr39poSRvOXDTB0y3hQng', // The chair, and effective meeting roles and skills
  'http://cslearning.gov.uk/modules/GV4AVEJIRjOs4IjWR6lqmg', // Meeting facilitator and participant: role and skills
  'http://cslearning.gov.uk/modules/EYWaFPDYTEymNx7UFhZBDQ', // Managing challenging behaviours and attitudes
  'http://cslearning.gov.uk/modules/PZvJ2t8zQjW0GN_9Wpt7hQ', // Managing challenging behaviours and attitudes: an optional case study
  'http://cslearning.gov.uk/modules/90BV4JS0TlORK6X7tU3mGw', // Digital skills in the UK quiz
  'http://cslearning.gov.uk/modules/ddw2forxQcyBr9S8oenbmA', // Digital transformation
  'http://cslearning.gov.uk/modules/K2nq3uOASBizRIKGG6PDFQ', // Working remotely
  'http://cslearning.gov.uk/modules/YYoV__VqSHK52SmHIPSpHA', // Online tutorial: stress management
  'http://cslearning.gov.uk/modules/Yi_SNOFFTNGQdlifdt6lWg', // Types of application
  'http://cslearning.gov.uk/modules/ZfgoP6HfTmKbgTrBy0lYYA', // Writing behaviour examples
  'http://cslearning.gov.uk/modules/oqwOyS4mQoetCu2yfk5ihQ', // What's the question?
  'http://cslearning.gov.uk/modules/Ixv7hkmwSFelFyR8QS-5Wg', // What's the question?
  'http://cslearning.gov.uk/modules/jrKZ_WTwR_2d6kTCjKCeqw', // Inclusion and diversity in assessment 
  'http://cslearning.gov.uk/modules/Xmr3Upw0QaG-piEF5qKH-Q', // Match the method 
  'http://cslearning.gov.uk/modules/0Kq70fxcSDe8Qi2qaABUPQ', // Inclusion and diversity in assessment 
  'http://cslearning.gov.uk/modules/E5Xl3aNVTCG9Ea7ftg1zew', // Match the method 
  'http://cslearning.gov.uk/modules/2OkOHzzpRAuJPE34MXe32A', // Looking at the overlooked
  'http://cslearning.gov.uk/modules/6Rsi3i71Qm-d-KvF8wEQlA', // Workplace scenarios tutorial
  'http://cslearning.gov.uk/modules/okZNVSO_QImXf-_FEiFK1Q', // Customer insight: the basics 
  'http://cslearning.gov.uk/modules/eao9TF-ZTYC0sne6ZrOPpw', // Connecting with your customers
  'http://cslearning.gov.uk/modules/R12Jxyt1Q5CvaqMocIyzSg', // Hypothesis writing
  'http://cslearning.gov.uk/modules/eGYkTE8jR3SzKbEA5J1U1Q', // How projects run: governance
  'http://cslearning.gov.uk/modules/Xe9hrAORQaCtm3O_vR8ltQ', // How projects run: roles and responsibilities
  'http://cslearning.gov.uk/modules/EOymqhg9RvuWuUCQnE0nCw', // How projects run: assurance
  'http://cslearning.gov.uk/modules/54UUx3JBST-cbQnPxKz9DA', // How projects run: test your knowledge
  'http://cslearning.gov.uk/modules/FFh7T0XJQ6KvI-dPvwBJ_Q', // test gomo scorm 1.2
  'http://cslearning.gov.uk/modules/uCBNeYg5TrGVYdRmOrudgg', // test Rise scorm 1.2
  'http://cslearning.gov.uk/modules/J3L33P81QKGPytccrPBO7g', // test Rise xAPI
  'http://cslearning.gov.uk/modules/oG58KOQESX2PSEvmuV9E6A', // Test gomo xAPI
  'http://cslearning.gov.uk/modules/09XC58wESE6UuTvjEejCXA', // Equality, diversity and inclusion in the Civil Service
  'http://cslearning.gov.uk/modules/WL1h-zhnRACC1d8uHNygDg', // Introducing Unconscious Bias
  'http://cslearning.gov.uk/modules/9P8i4qbfR92pr6eXhWLKEg', // Unconscious Bias in the Workplace
  'http://cslearning.gov.uk/modules/-lpBlTAFQL20rmgRh472Hw', // Unconscious bias in recruitment decisions
  'http://cslearning.gov.uk/modules/C1Mpb_QtTE6UbMzMF7dUGg', // Tackling our unconscious bias
  'http://cslearning.gov.uk/modules/wtXr_f8TQueSZdQJGrNNMg', // Our inclusive workplace
  'http://cslearning.gov.uk/modules/uFnb35EVQIiW_A_9vEu42A', // Our Customers
  'http://cslearning.gov.uk/modules/pO6EXHpERVGdeFngY918ZQ', // The Legal Framework 
  'http://cslearning.gov.uk/modules/3G2y-8YBQuCrVZ9peTDzRA', // Stress management 
  'http://cslearning.gov.uk/modules/0rYeuFNSTcC04Etd7oBaUw', // Counter fraud, bribery and corruption: all staff
  'http://cslearning.gov.uk/modules/of3ACQQ6QyWv5K1nNcpV2A', // Why is scope management important?
  'http://cslearning.gov.uk/modules/0Du3Y2IvSfahXzENDSvkDQ', // The human factor
  'http://cslearning.gov.uk/modules/AOI4Ewg7TNW7bHbC4sf4nw', // Managing changes to scope
  'http://cslearning.gov.uk/modules/f0wEQrZJQH2VqhQLbQQh6Q', // When change is needed
  'http://cslearning.gov.uk/modules/kUAr8MawS7GmUKuqV0JR0A', // Check your knowledge
  'http://cslearning.gov.uk/modules/XeFOpLCDRr6VtcCIibDSjg', // Inclusion and diversity in assessment
  'http://cslearning.gov.uk/modules/wxeAPUcOS-CHZjQtJFE8Tw', // Match the method
  'http://cslearning.gov.uk/modules/xzzznwYvQTChFgWQyrzFHg', // DBS Test Course
  'http://cslearning.gov.uk/modules/QT__HEnxQ9ipOTKrDuYjEA', // Data quality
  'http://cslearning.gov.uk/modules/U8GLDPqcSlykjmsorZ2SbA', // Online tutorial: communicate more effectively face-to-face with customers (ESSENTIAL)
  'http://cslearning.gov.uk/modules/W0zr0n-pRRmTd0Rfj64ghw', // Online tutorial: communicate more effectively at a distance (ESSENTIAL)
  'http://cslearning.gov.uk/modules/L-MiB3YPTb6vtwRZcsV99w', // Online tutorial: listen more actively and improve your communication skills (ESSENTIAL)
  'http://cslearning.gov.uk/modules/BDeleVmITGmUjF5HiPADbg', // Active listening knowledge check (ESSENTIAL)
  'http://cslearning.gov.uk/modules/C6ato2h8TGi-8XkOM9hdVg', // Types of application
  'http://cslearning.gov.uk/modules/cRF9nRcRQb2uBLP0WLYzdw', // Writing competency examples
  'http://cslearning.gov.uk/modules/6EIOXW1LRU-rteTOg1nU0g', // Teamworking
  'http://cslearning.gov.uk/modules/ivgPUL-gSy-T1lwbv4FQsA', // test elearning
  'http://cslearning.gov.uk/modules/MQ2G4UgXSSWr2XBl9ucnTQ', // testing again
  'http://cslearning.gov.uk/modules/q1CXwBqoSZipMEY-beRgPA', // TEST
  'http://cslearning.gov.uk/modules/NJoiFW7aQ-Sw9zLVNTHAWA', //  Analysis and working with analysts
  'http://cslearning.gov.uk/modules/7QnpKQS_TMimWdsFa12zxw', // How to engage stakeholders
  'http://cslearning.gov.uk/modules/Ze2LCYlWRKWtMCWdM-AC7w', // How to define requirements
  'http://cslearning.gov.uk/modules/mNBeeZgRT7mjbBWnVSb6uA', // Stakeholder management: check your knowledge
  'http://cslearning.gov.uk/modules/xwRuvBKIQSGMPDwqMnOsWg', // Counter fraud, bribery and corruption: managers
  'http://cslearning.gov.uk/modules/nMn_FsvATuimDRHWSPH7hw', // Counter fraud, bribery and corruption: all staff
  'http://cslearning.gov.uk/modules/k3tZh0vATQebQ-4e9_hg7Q', // Quiz
  'http://cslearning.gov.uk/modules/JqpkTMADSx-9Tr88bd_RgQ', // Attendance management essentials 
  'http://cslearning.gov.uk/modules/f9Tql-dLQTubdHO7SIArEA', // Managing the attendance process
  'http://cslearning.gov.uk/modules/O0E8S2eSTWGQ5Ag4Gfm80g', // Challenge 1 
  'http://cslearning.gov.uk/modules/kPeff9tGTRSoU0W_EssWhA', // Challenge 2 
  'http://cslearning.gov.uk/modules/C7NdIInPQraWlGJnF7CagA', // Test
  'http://cslearning.gov.uk/modules/9dLNBz84TAKLPnMQN3ZUOw', // Test
  'http://cslearning.gov.uk/modules/sLGIlULmSpi8GLZfevw92w', // The right answer (ESSENTIAL)
  'http://cslearning.gov.uk/modules/Y0A0ZA9STfmewkx-zDBWNA', // Communicate more effectively face-to-face with customers
  'http://cslearning.gov.uk/modules/XYDebb-TQ_2Ky_XjbtJhYg', // Communicate more effectively at a distance
  'http://cslearning.gov.uk/modules/GPTKuml9SBy0K9oZQeqlFQ', // Listen more actively and improve your communication skills
  'http://cslearning.gov.uk/modules/OMwyvNnzSNmHTCI5725hWg', // Active listening knowledge check
  'http://cslearning.gov.uk/modules/2SY0PWoRQ_a3JYJOOq0-gA', // Recognising customer dissatisfaction 
  'http://cslearning.gov.uk/modules/fscVIfxeTf2spBcVhivynw', // Handling customer dissatisfaction
  'http://cslearning.gov.uk/modules/6n0V7VH2TAyacJ2ZPu1NkQ', // The final steps of the complaints process
  'http://cslearning.gov.uk/modules/2avSH3LqSDeD6rJt4g2eZg', // 4S framework for quality conversations
  'http://cslearning.gov.uk/modules/BDHx47ldS0aAuqHsgy0fPg', // Emotional intelligence overview
  'http://cslearning.gov.uk/modules/U57hRgUeShaV3LRyXrvBIg', // Building emotional intelligence
  'http://cslearning.gov.uk/modules/O2gNaACaQCe_pDpYhPJkcA', // Building self-awareness
  'http://cslearning.gov.uk/modules/LM_XFMh3QzSBKx7thxtuSg', // From self-awareness to self-management
  'http://cslearning.gov.uk/modules/123Jr1HCTDC2I6f8CKCvSQ', // Engage more effectively with your customers
  'http://cslearning.gov.uk/modules/ZvPOaV7ORhqePYlMoH-sdQ', // Countering Fraud, bribery and corruption for All staff
  'http://cslearning.gov.uk/modules/1SwG43trQ2aq2EGLRdm3TA', // Countering Fraud, bribery and corruption for Managers
  'http://cslearning.gov.uk/modules/cMIxQ57lQY6x0RbfKu1wfA', // ML1.1 - DIVERSITY AND INCLUSION - INTRODUCING UNCONSCIOUS BIAS
  'http://cslearning.gov.uk/modules/CtRaF8a4QCWzxItW8IAzhA', // ML1.2 - DIVERSITY AND INCLUSION - UNCONSCIOUS BIAS IN RECRUITMENT DECISIONS
  'http://cslearning.gov.uk/modules/JOnLBKfQQACq9eIG9QjOWg', // ML1.3 - DIVERSITY AND INCLUSION - UNCONSCIOUS BIAS - UNCONSCIOUS BIAS IN THE WORKPLACE
  'http://cslearning.gov.uk/modules/cEwRc71DRZWLThSvWyAsbw', // ML1.4 - DIVERSITY AND INCLUSION -UNCONSCIOUS BIAS - TACKLING UNCONSCIOUS BIAS
  'http://cslearning.gov.uk/modules/MU-XMLE9Q7qg1Zjlz3s4pA', // ML1.5 - MANDATORY - EQUALITY AND DIVERSITY AND INCLUSION IN THE CIVIL SERVICE
  'http://cslearning.gov.uk/modules/6epUmD5nR5KpLWEVTwPPzQ', // ML1.6 - MANDATORY - THE LEGAL FRAMEWORK
  'http://cslearning.gov.uk/modules/piEVM-kLTxuKHPACeque3w', // ML1.7 - MANDATORY - OUR INCLUSIVE WORKPLACE
  'http://cslearning.gov.uk/modules/4p0xoi9mQAiEjzHs4upj7A', // ML1.8 - MANDATORY - OUR CUSTOMERS
  'http://cslearning.gov.uk/modules/aIN2q0g2RjGttERog9mS-Q', // ML3.1 - MANDATORY HEALTH AND SAFETY - STRESS - STRESS IN THE WORKPLACE
  'http://cslearning.gov.uk/modules/iBtHDdRKSaGfe_L7HK6U8g', // ML3.2 MANDATORY - SLIPS AND TRIPS AND FALLS
  'http://cslearning.gov.uk/modules/FH3UoS4ZTN26A6hLgVit4Q', // ML3.3 - MANDATORY - HEALTH AND SAFETY - DISPLAY SCREEN EQUIPMENT - USING DISPLAY SCREEN EQUIPMENT
  'http://cslearning.gov.uk/modules/_sF20i3oR9KdyqVEZrzhIA', // ML3.4 - MANDATORY - HEALTH AND SAFETY - HEALTH AND SAFETY FOR MANAGERS
  'http://cslearning.gov.uk/modules/9QlhJDJXSy-KXWADWJGVjg', // ML3.5 - MANDATORY - HEALTH AND SAFETY - BASIC FIRE SAFETY
  'http://cslearning.gov.uk/modules/zmEh2e6iSQagTfvbv_iq3g', // ML3.6 MANDATORY - MANUAL HANDLING
  'http://cslearning.gov.uk/modules/Xj2KAHw8RTanXmrL9rYQdA', // ML21 RFI - Government Security Classifications
  'http://cslearning.gov.uk/modules/K5fNivChRWCxzyOhympCEg', // ML22 RFI - Protecting and Sharing Information
  'http://cslearning.gov.uk/modules/GY39Y13oR_aVSRUPTNrg7g', // ML23 RFI - In The Workplace
  'http://cslearning.gov.uk/modules/_koh6RCUQt-ZzNIvu4kNhQ', // ML24 RFI - Working Flexibly
  'http://cslearning.gov.uk/modules/LETkYBZGRVCKxxT7TwIwfQ', // ML25 RFI - Staying Safe Online
  'http://cslearning.gov.uk/modules/WQI0NcXlRt6q9ErTCVDGww', // ML26 RFI - Fraud
  'http://cslearning.gov.uk/modules/K3a0jHRLQBazQAAEFdbULg', // ML27 Mandatory - Managing Information As An Asset
  'http://cslearning.gov.uk/modules/uRxhewvkRc-oeaf6pXNL_Q', // 4S framework for quality conversations
  'http://cslearning.gov.uk/modules/PU8xsKdLRHmaTcb4bK82Hw', // Online tutorial: coaching foundations
  'http://cslearning.gov.uk/modules/dtRe3-HsTUW0-KkZ3UwmbA', // Online tutorial: coaching in action
  'http://cslearning.gov.uk/modules/Kbbgqg9nTQulJUd3RnPPNg', // Giving constructive feedback
  'http://cslearning.gov.uk/modules/NYrulkuJTyqXazSVVksC0g', // Commercial models
  'http://cslearning.gov.uk/modules/1cYJolKcR0GX7ddwR7HEfQ', // Driving behaviours and innovation
  'http://cslearning.gov.uk/modules/0rV8mbPYSiyxj6jyskn2ZA', // Supplier motivation and risk transfer
  'http://cslearning.gov.uk/modules/nmvgsF15Tee-HY0c4Jxt9Q', // Knowledge check
  'http://cslearning.gov.uk/modules/bH-Qb5S6TCK32yvwh5EChQ', // The right answer 
  'http://cslearning.gov.uk/modules/zh5kz2J-RSGB1iUIeARjSA', // Requirements and demand for the service
  'http://cslearning.gov.uk/modules/83OivOalSO6Zd2VxWQKczg', //  Marketing and purchasing power
  'http://cslearning.gov.uk/modules/Q3UxxjJiThmCLKtD8RfYyQ', // Strategic commercial decisions
  'http://cslearning.gov.uk/modules/Terq3AXdRD2EwnXiKM0JZQ', // Knowledge check
  'http://cslearning.gov.uk/modules/Zo6OwVWSQpazJZgVt-wbRw', // Market engagement
  'http://cslearning.gov.uk/modules/OnK-2xYrR3qtRi1RAXbW0Q', // Specifications, evaluation and contract award
  'http://cslearning.gov.uk/modules/Z0vC6cC9SLa_HNmjPc21mA', // Public sector procurement procedures
  'http://cslearning.gov.uk/modules/SO7znSRCQISghPwXPsuudg', // Knowledge check
  'http://cslearning.gov.uk/modules/cp-9eOgNQ-aU1s8_oYESJg', // Introduction to project delivery in government
  'http://cslearning.gov.uk/modules/MinO1n41TkCEP3qHxUfVtA', // Perspective on projects
  'http://cslearning.gov.uk/modules/59WS_Da_S6mxC60eA619AA', // How projects are run
  'http://cslearning.gov.uk/modules/HNf0YM9PQkSbjkS57u2xQQ', // Developing robust policy: the 3 pillars
  'http://cslearning.gov.uk/modules/fKb07zGHT2yy17G01W6CJQ', //  Framework for effective delegation
  'http://cslearning.gov.uk/modules/1Cg2WgP-RmmZ_DQrlF67EQ', // Planning delegation
  'http://cslearning.gov.uk/modules/sFr9tsigToCBPvXSoEtjoQ', //  7 steps of delegation
  'http://cslearning.gov.uk/modules/b-GVeJ4mTACk285GbJyMoQ', // Getting The Most From Matrix Working
  'http://cslearning.gov.uk/modules/HGRVKRahSCCtsYNuLcentQ', // Finance foundations
  'http://cslearning.gov.uk/modules/CP5HkeuqSJymP4goJkDsmA', //  Tutorial 1: Founding principles and the history of the EU (CORE) open elearning
  'http://cslearning.gov.uk/modules/exG5UOZyTVa1JKyEGBPo3w', // Tutorial 2: European law and institutions (CORE) open elearning
  'http://cslearning.gov.uk/modules/kGIfTq4ORMSQTO-Szhk-gQ', // Tutorial 3: Responsibilities and finance (CORE) open elearning
  'http://cslearning.gov.uk/modules/ufCgrOVHTB-et3c5KOSDCQ', // Tutorial 4: EU external relations (CORE)
  'http://cslearning.gov.uk/modules/Bo343csXRzeRE3ra6ngmyw', // Data Visualisation 101 e-Learning
  'http://cslearning.gov.uk/modules/IVfceYSPQje-fjdeAcfgzA', // Framework for effective delegation (ESSENTIAL)
  'http://cslearning.gov.uk/modules/98ShYMELTk2kMzeRHxoi6Q', // Planning delegation (ESSENTIAL)
  'http://cslearning.gov.uk/modules/BW4b-UJ7SzyBjQ8UfJoJrA', // 7 steps of delegation (ESSENTIAL)
  'http://cslearning.gov.uk/modules/Wcfu9fRXTkWZ2f3ZqcKOFg', // Data quality
  'http://cslearning.gov.uk/modules/m13YVuqnQ-aDURrnv2ELfQ', // Introduction to constitution and devolution settlements 
  'http://cslearning.gov.uk/modules/oOe2ekL1R5SyxM80_5DmOA', // Governments working together
  'http://cslearning.gov.uk/modules/TSexR-brQ-GafcUKwgoLCA', // Devolved governments and legislative processes
  'http://cslearning.gov.uk/modules/OFtULZ7bTRuIDeOXhziUOg', // Local devolution across the UK
  'http://cslearning.gov.uk/modules/FpAQkx_GSaWeWpqGbKScBw', // test leo course
  'http://cslearning.gov.uk/modules/caaQeT0TTPWsR23rx5zLwA', // Test DI
  'http://cslearning.gov.uk/modules/Z81me3sKQ-GbNQ8QLPqVLA', // Systems and complexity
  'http://cslearning.gov.uk/modules/SLPGp8Y7Sv-87HDmaxEwBw', // Social media quiz
  'http://cslearning.gov.uk/modules/VKdtm20uQtuoswwO4NbDEQ', // Why social media? 
  'http://cslearning.gov.uk/modules/YzKk_be6SD2IACgbB91cZg', // Introduction to social media
  'http://cslearning.gov.uk/modules/JCvZ84yqTZKFPGDqg8Ltuw', // What is it good for?
  'http://cslearning.gov.uk/modules/5WFSorMMSXaY_flvyyqtvQ', // Knowledge check
  'http://cslearning.gov.uk/modules/0gs2ucZbSb6GCTuNhADE-Q', // What is a business case?
  'http://cslearning.gov.uk/modules/OTr2SdEjRWuN1reEylyaXA', // How are business cases produced? 
  'http://cslearning.gov.uk/modules/fF3RhoWJRlKosMlgCDwEhQ', // Business cases in action
  'http://cslearning.gov.uk/modules/Lnr7DOTSR4Kom68oFLF6gg', // Knowledge check
  'http://cslearning.gov.uk/modules/LlHydKeWTvGAI7W6f7IUWA', // Achieving and measuring quality
  'http://cslearning.gov.uk/modules/nD6MghtISsyOLYmjhU_6WA', // Perspectives and approaches
  'http://cslearning.gov.uk/modules/Wb9dQZaiTJiImX2-JMgZGQ', // test Govt
  'http://cslearning.gov.uk/modules/uLEVg-taQuy42ZemdoJ5ww', // Tutorial 1: founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/Pbk8uCr3TGK7lU40dVPEEQ', // Tutorial 2: European law and institutions
  'http://cslearning.gov.uk/modules/QLjIhLQ3TfCAw0egkDx4Jw', // Tutorial 3: responsibilities and finances
  'http://cslearning.gov.uk/modules/hmSIa1QxSvyQG_iMWZi72w', // Tutorial 4: EU external relations
  'http://cslearning.gov.uk/modules/pzP_iQs1RMSb9ApA1ywkJQ', // Assessing misconduct
  'http://cslearning.gov.uk/modules/BN0-i64vSXSpH9yk8f8mag', // Assessing complaints
  'http://cslearning.gov.uk/modules/ii_i9V8DSES22lJeO6EmhQ', // Assessing misconduct and complaints quiz
  'http://cslearning.gov.uk/modules/ADE9yeb_TSS1WHXscWMUAg', // Carrying out investigations
  'http://cslearning.gov.uk/modules/va3j4pF5SnOLT-E58kc-Ng', // Making decisions
  'http://cslearning.gov.uk/modules/ZCdDUnGHQUKBybV86obRFQ', // Scenario
  'http://cslearning.gov.uk/modules/-8gYu8-eSty650kY1m4zhg', // Online tutorial: the secrets of storytelling
  'http://cslearning.gov.uk/modules/y2fRmN0oQVujYYKC3RVNCw', // 4S framework for quality conversations
  'http://cslearning.gov.uk/modules/ASPCZOQsSJS9tj1lTA__rA', // Workplace scenarios online learning
  'http://cslearning.gov.uk/modules/oYjn8UjfTymMxPct5Binkg', // Online tutorial: stress management
  'http://cslearning.gov.uk/modules/EfdCcaifRgeFRfjS0Q_haw', // Giving constructive feedback
  'http://cslearning.gov.uk/modules/T49kNYHsSVmDrPFp5v_rlg', // Introduction to commercial in government
  'http://cslearning.gov.uk/modules/RuEJBF90QZqmhHN1ot4YPw', // The commercial cycle explored
  'http://cslearning.gov.uk/modules/XzwMTqneQR-PCpxLAuaW-Q', // Knowledge check
  'http://cslearning.gov.uk/modules/kQxzcvtqTUimybOO2I1xlg', // Counter fraud, bribery and corruption: all staff
  'http://cslearning.gov.uk/modules/U4e5IB1oR4yBopZ4_k_ggQ', // Digital and you: part 1
  'http://cslearning.gov.uk/modules/dvMHXjHvTxCGoOy4pWAuMA', // Digital transformation
  'http://cslearning.gov.uk/modules/yfL4QK7ORNOjJ48vdhoNeQ', // Building quality digital services: part 1
  'http://cslearning.gov.uk/modules/uKrAz5NMQFuhGj6QNvht1A', // Making informed decisions
  'http://cslearning.gov.uk/modules/vubAbg0fQ0u4KS7ePCjBxw', // Practical skills 
  'http://cslearning.gov.uk/modules/76GG9YaYRt2NxJi8Txq4YA', // Meeting customer needs 
  'http://cslearning.gov.uk/modules/MHs2t6WRRNqI9yhoiWD6Bw', // Analysis and working with analysts
  'http://cslearning.gov.uk/modules/1Yes0cCrTFW4w9kjtqgF-g', // Test 2
  'http://cslearning.gov.uk/modules/ijCxR85tTQGQugu_fzjyHw', // Assessment e-learning
  'http://cslearning.gov.uk/modules/W0WyQ9twTcuB8pCqrl49Mg', // Working with Agile 2
  'http://cslearning.gov.uk/modules/rAbjphOGRcC4r2maUo-ucg', // Get to grips with statistics
  'http://cslearning.gov.uk/modules/dPcf9reiSwmgEq8g6ap13A', // What's the question
  'http://cslearning.gov.uk/modules/DsOHRS3kQk-njlAChU142g', // Protecting and sharing information
  'http://cslearning.gov.uk/modules/dsip9tWZR6mNkCGU29o7qw', // In the workplace
  'http://cslearning.gov.uk/modules/C9LqlnK3Qjm9TvRsw3rulA', // Working flexibly
  'http://cslearning.gov.uk/modules/jS0T3yAIQlq-NvFk6nMWWw', // Data visualisation: 101
  'http://cslearning.gov.uk/modules/oWafdxzcT_a5O7FpLY6Z1A', // Follow the money
  'http://cslearning.gov.uk/modules/719azlQqQKOha5cmBNUe1Q', // How finance works in your department
  'http://cslearning.gov.uk/modules/X2rGwd92SWSEM-tKxsrutA', // Staying accountable
  'http://cslearning.gov.uk/modules/WspptU8xT0i196PnDWKYqg', // Knowledge check
  'http://cslearning.gov.uk/modules/TKXa4s19RA6qOTJgUV4n-A', // Parliament E-Learning [TEST]
  'http://cslearning.gov.uk/modules/SKy0z0liSiCb75M8l7ioCw', // CFBC
  'http://cslearning.gov.uk/modules/-2IP1MznTsm3i47pS_WriQ', // CFBC1
  'http://cslearning.gov.uk/modules/uQKwvVcUQIW6MBAetOaRIQ', // Recognising assertive behaviour
  'http://cslearning.gov.uk/modules/GBnbIx4uRte2pCBDJ6jGuQ', // Benefits of assertiveness behaviour
  'http://cslearning.gov.uk/modules/dNr0kSE4TZiWbAEoLAqWpg', // Requirements for assertive communications
  'http://cslearning.gov.uk/modules/sLkC0T2mRpa16wZ8JFjscQ', // Assertive communications
  'http://cslearning.gov.uk/modules/OtD6BcJzQOOy_iJ252vWBQ', // Communicating assertively
  'http://cslearning.gov.uk/modules/JQQpTvihSjS0Q_22AaSrkQ', // Tutorial 1: Founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/VnJr-hlkT--eyN7PaUlIpw', // Tutorial 2: European law and institutions
  'http://cslearning.gov.uk/modules/4Ee-5MVTR4iPEa3oR1hckA', // Tutorial 3: Responsibilities and finance
  'http://cslearning.gov.uk/modules/otIG0vP3QQC9AGkayHeYfQ', // Tutorial 4: EU external relations
  'http://cslearning.gov.uk/modules/7LTp_SRURia0PSgJyFkHVQ', // test 01 IN UB
  'http://cslearning.gov.uk/modules/QAhfUqSJR3yE-LYJOwWXOQ', // TEST UB rec
  'http://cslearning.gov.uk/modules/4l1kF2YrREmmfCJL6h5SmQ', // Test
  'http://cslearning.gov.uk/modules/LCzWRA5fSmK3lrt5CwvGaQ', // Introduction to managing government general grants
  'http://cslearning.gov.uk/modules/N80TY9VvT969NUyOSCq5sQ', // Managing poor performance: managing poor performance procedure
  'http://cslearning.gov.uk/modules/ZEJa5rG4QlunF1zy6ojJYA', // Managing poor performance: managing dips in performance
  'http://cslearning.gov.uk/modules/nIsrBucTQdWlNNFmaF_3fg', // Managing poor performance: important issues
  'http://cslearning.gov.uk/modules/PD79Yn1GSBibjRsktW9FOw', // Managing poor performance: poor performance scenarios
  'http://cslearning.gov.uk/modules/Guv1sNgnSWuY_ps_PJtYIg', // Managing poor performance: in-depth scenario
  'http://cslearning.gov.uk/modules/kZTJSJbVSI-x9PGlBYArlA', // What's the question?
  'http://cslearning.gov.uk/modules/4vwhuVAUS1CrmDLXyDC2iQ', //  Understand your change
  'http://cslearning.gov.uk/modules/n2dAyiY8QNq1j7NnrW-KIA', // Understand your stakeholders
  'http://cslearning.gov.uk/modules/Lwxg1eIKS5imR7gGtpmsTg', // Plan your change
  'http://cslearning.gov.uk/modules/D-oy2NZwRXOmHdwS2SNXnw', // An introduction to they psychology of change
  'http://cslearning.gov.uk/modules/lmJxsF10S8Oa0o0hBDZFsg', // Government security classifications
  'http://cslearning.gov.uk/modules/te0u0D5zR6mrnMRZCrOmJg', // Protecting and sharing information
  'http://cslearning.gov.uk/modules/klNU1pN1Qg-09LrK3eBelw', // In the workplace
  'http://cslearning.gov.uk/modules/nfIEYGMxSu6QBQzu7HKiTQ', // Working flexibly
  'http://cslearning.gov.uk/modules/9rMuXj_kTs608RGBjsYXFA', // Staying safe online
  'http://cslearning.gov.uk/modules/Au3g2ByPRHW9jSx2uDJgGQ', // Fraud
  'http://cslearning.gov.uk/modules/O-vAciyRT_KyWTst3cBW5A', // Managing information as an asset
  'http://cslearning.gov.uk/modules/VQSPPqxRRmeXVVvGOphBoA', // Stress in the workplace
  'http://cslearning.gov.uk/modules/lgMoLPpuSIO7w_iaBKhFtQ', // Slips, trips, and falls
  'http://cslearning.gov.uk/modules/XvaBSkcwQNuYLVc4goAgIw', // Basic fire safety
  'http://cslearning.gov.uk/modules/u30Qc_bET6SGLWXl3OVnTQ', // Manual handling
  'http://cslearning.gov.uk/modules/y8tnPpfgQmqD9jgJOwf74w', // Health and safety for managers
  'http://cslearning.gov.uk/modules/sMWO4VJZSGKi-kKyimDryw', // Using display screen equipment
  'http://cslearning.gov.uk/modules/m5xmGsKfRjuUUw7ra5SyCg', // Principles of budgeting
  'http://cslearning.gov.uk/modules/bKab_YjxSIa6K4r9UvplHA', // Creating a budget
  'http://cslearning.gov.uk/modules/OFltPAtUT2GhJbZhv3GxIQ', // Managing a budget
  'http://cslearning.gov.uk/modules/jiSbnlZjRM6SD5UdaxRzFg', // Knowledge check
  'http://cslearning.gov.uk/modules/bbFh--dkQxepEMrmdFe7nQ', // What's the question? Online tutorial
  'http://cslearning.gov.uk/modules/GjLFMxSOQW-DcUbpFds2Qw', // Framework for effective delegation
  'http://cslearning.gov.uk/modules/Rpf16o2ZRJ2JlkbNo6uwnw', // Planning delegation
  'http://cslearning.gov.uk/modules/BVD5eY1IQciSc1Ok4eKGeA', // Seven steps of delegation
  'http://cslearning.gov.uk/modules/QxcrYP1tQBCAU6RJEkFukw', // Practical skills
  'http://cslearning.gov.uk/modules/CaSzXJKSSbKWFSomvNN-aQ', // Meeting customer needs
  'http://cslearning.gov.uk/modules/kPG5i8UVSfeDGYpVKN_30Q', // Giving constructive feedback 
  'http://cslearning.gov.uk/modules/HH6PO9huRIayMAMMq4D3Rw', // An introduction to the psychology of change
  'http://cslearning.gov.uk/modules/RmqS12AsT_um6K9n5xh6SA', // Pre-workshop activity: Workplace scenarios tutorial
  'http://cslearning.gov.uk/modules/OPMdTutkRnG3Nybc0tnOuA', // Becoming disability confident: an introduction
  'http://cslearning.gov.uk/modules/EFGEhtCsTSO5-U_xrl8p9w', // Visible and non-visible disabilities
  'http://cslearning.gov.uk/modules/lycpwD_WS86_u43etA6Q-g', // Managing a diverse team
  'http://cslearning.gov.uk/modules/sh4Zslj-RqqEiqbKSJFU8g', // Case studies
  'http://cslearning.gov.uk/modules/clMpvbHBRyS8M01aDRzLeA', // Knowledge check
  'http://cslearning.gov.uk/modules/4S86nlf_SJyNOyX8t8_DZA', // Acquired disability: scenarios
  'http://cslearning.gov.uk/modules/GGxTBeLqSXejaABC_rVQbw', // Learning disability: scenarios
  'http://cslearning.gov.uk/modules/hcC5Wso9TNiyXYlK6PCBXA', // Visible disability: scenarios
  'http://cslearning.gov.uk/modules/aPXlUP-iT3OYq5vne8tLGQ', // Non-visible disability: scenarios
  'http://cslearning.gov.uk/modules/MV4whtMfQBKsOELWoB2fIw', // Neurodiversity: scenarios
  'http://cslearning.gov.uk/modules/1EVLMBeRTc62anxrP9zIag', // Stress in the workplace
  'http://cslearning.gov.uk/modules/quG0d-6LQMCWf3Sas419_w', // Slips, trips, and falls
  'http://cslearning.gov.uk/modules/-z9W7JZUTzSqYNS99XbaKA', // Basic fire safety
  'http://cslearning.gov.uk/modules/aSUbnlGMSFeeHBeYVwLL5w', // Manual handling
  'http://cslearning.gov.uk/modules/mxTR5dP7Q3GwDm_YuypElg', // Health and safety for managers
  'http://cslearning.gov.uk/modules/wxW5BeW8RGGoq2mmbDwDtw', // Using display screen equipment
  'http://cslearning.gov.uk/modules/kL6pbF30QLqv5FP6Fvs9CQ', // Counter fraud, bribery and corruption: managers
  'http://cslearning.gov.uk/modules/85TBliW9QFCAyIgm_agAVA', // Stress management
  'http://cslearning.gov.uk/modules/3WyUfVGGSk2R4Iof8QAh2g', // RPS elearning
  'http://cslearning.gov.uk/modules/iP7qvelpQt2pNFRj-damcg', // The commercial journey
  'http://cslearning.gov.uk/modules/MZuUvS7qS8edxgTKh7-yKw', // The 6 hallmarks of collaboration
  'http://cslearning.gov.uk/modules/QbHW-v__SOieL-vKpJ5LwA', // Skill up
  'http://cslearning.gov.uk/modules/Th5GYhjnTgaTiwr_0pVOVQ', // TEST LOAD
  'http://cslearning.gov.uk/modules/1ABiYxsdQH2BDzBNm6ReDQ', // TEST
  'http://cslearning.gov.uk/modules/a0NXfcirR9mkIj4E86VGcQ', // Going the extra mile: be engaging
  'http://cslearning.gov.uk/modules/yHe_VPY4SXiuv5dvk8Vo7Q', // Going the extra mile: provide support
  'http://cslearning.gov.uk/modules/jM8iSMqxRhCRAB9dJX7nXg', // Going the extra mile:  can you provide excellent customer service?
  'http://cslearning.gov.uk/modules/Oa9kDjYST-uB-hI_dZcRzQ', // Team leader insights
  'http://cslearning.gov.uk/modules/1AdQbePeTTqezzlODWcwbw', // Removing barriers to effective teams
  'http://cslearning.gov.uk/modules/1EZP1PBVSkW3eB9o1B-e1w', // Team development
  'http://cslearning.gov.uk/modules/sonRv9yWQfaUbl1f9vL7UQ', // Effective teams
  'http://cslearning.gov.uk/modules/B1JDycCJTkeWSTY3g_e9gg', // Leading a team
  'http://cslearning.gov.uk/modules/CB4jkX-cR0-Q1ZzNN7c4bg', // Managing team roles
  'http://cslearning.gov.uk/modules/on-a-sP0RwCQW-RlEVxvjA', // Vision and purpose
  'http://cslearning.gov.uk/modules/wnvHNpusQ6GJCPRSo2iBeA', // Disability facts and figures
  'http://cslearning.gov.uk/modules/8a6h91xrTleNYFV8-CKL1A', // The importance of project planning
  'http://cslearning.gov.uk/modules/YXJ8rqiaQrGPtszYgw3G3Q', // Project planning
  'http://cslearning.gov.uk/modules/PJ6esN64SCStjeBrI8Y3Vg', // Creating and maintaining a plan
  'http://cslearning.gov.uk/modules/mxvdRBP3Tu25BlD0mf0HRw', //  Reacting to changes to your plan
  'http://cslearning.gov.uk/modules/rkoqm57kRBGBeqc5QamYtA', // Project planning: quiz
  'http://cslearning.gov.uk/modules/eNGqZQ6RR5ebKC_Y6rxvtA', // Temp
  'http://cslearning.gov.uk/modules/UGUJLfheQPaRS5YRDBt6fg', //  Challenging customer behaviours
  'http://cslearning.gov.uk/modules/QyKfctDjTLKjr7coG_eU2g', //  Managing challenging customer behaviour
  'http://cslearning.gov.uk/modules/UYqxITeRRS6YRRhLYqzIIQ', // Handling challenging customers: avoiding conflict
  'http://cslearning.gov.uk/modules/TL4EMsWnS9a0pI0adskkWg', // Counter fraud, bribery and corruption: managers
  'http://cslearning.gov.uk/modules/7O2vmsHzQXOCyFRPWxZ5KQ', // Follow the money
  'http://cslearning.gov.uk/modules/yoSnEBGTRaqAYfzHQJ7EGw', // How finance works in your department
  'http://cslearning.gov.uk/modules/9Esk1C12STq7fCFr0ksQQw', // Staying accountable
  'http://cslearning.gov.uk/modules/sN5CeYWJQOqL1wahltGIog', // Knowledge check
  'http://cslearning.gov.uk/modules/9FqJE5uWQseLcWeDyVAWkA', // The right answer 
  'http://cslearning.gov.uk/modules/XslD8lowSuiWBpYrGRqkpQ', // Practical skills
  'http://cslearning.gov.uk/modules/ebD7HY2FSge-JTEtLEtRPQ', // Meeting customer needs
  'http://cslearning.gov.uk/modules/9JAagwZ7R_aXZ7tMOfnXiA', // Introduction to constitution and devolution settlements
  'http://cslearning.gov.uk/modules/1mfB5OgPRI-8DDmPYVe8kg', // Governments working together
  'http://cslearning.gov.uk/modules/7g55VccSSHye_xcJxOZFWw', // Devolved governments and legislative processes
  'http://cslearning.gov.uk/modules/vapQfjWkRseSkgn-Pgkd4Q', // Local devolution across the UK
  'http://cslearning.gov.uk/modules/a3E8Iz9qRJK7KoMZzlVr1g', // Tutorial 1: Founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/tSmMgBHaQampNDEZeV3G4g', // Tutorial 2: European law and institutions
  'http://cslearning.gov.uk/modules/RpeWsVfoSPyYlYZgYTCCcQ', // Tutorial 3: Responsibilities and finance
  'http://cslearning.gov.uk/modules/_fCPvadXTf-YV8w1x2K4Yg', // Tutorial 4: EU external relations
  'http://cslearning.gov.uk/modules/Cg1kT-LATre7lFXGATOR7Q', // Tutorial 1: Founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/qAnK0CxGTCWFdaQIWt4dZw', // Tutorial 2: European law and its institutions
  'http://cslearning.gov.uk/modules/3z4XSVryQ2iOLhgGO6T0JA', // Tutorial 3: Responsibilities and finance
  'http://cslearning.gov.uk/modules/gSVKAyIuRL2hm72G5mk17A', // Tutorial 4: EU external relations
  'http://cslearning.gov.uk/modules/AahhHBWtSkeuREhAkhcFQg', // Tutorial 1: founding principles and the history of the EU
  'http://cslearning.gov.uk/modules/Wi4-ovv9QjurqGfiU-okkA', // Tutorial 2: European law and its institutions
  'http://cslearning.gov.uk/modules/gZvWL78JQPajUMG73Q7f9g', // Tutorial 3: Responsibilities and finance
  'http://cslearning.gov.uk/modules/AzVx8x2DTa-UdE1s53pFeg', // Tutorial 4: EU external relations
  'http://cslearning.gov.uk/modules/_1BZSKc6QFiM1pmGK_HhuQ', // Introduction to contract management foundation
  'http://cslearning.gov.uk/modules/wMGuZ1GHRnG50hE4Leq9MQ', // Procurement and mobilisation
  'http://cslearning.gov.uk/modules/jglbGZnpQ9Sz6GzmpjtXzg', // Managing contract delivery
  'http://cslearning.gov.uk/modules/K7pCQ-TBRN-W60eZo4Fhbw', // Change control
  'http://cslearning.gov.uk/modules/f0APTsd9RLCgGHHXhE7Rtg', // Stakeholder engagement
  'http://cslearning.gov.uk/modules/a8MNz2J4T_WCnZTeZJPknQ', // Risk management
  'http://cslearning.gov.uk/modules/BEjsXlFpQIiGbfA6YWrGgQ', // Your foundation assessment
  'http://cslearning.gov.uk/modules/Y9YE5qXGS_a0KgZzMas1XA', // Equality and diversity and inclusion in the Civil Service
  'http://cslearning.gov.uk/modules/FPaBq_ikRbikkXJV_R36EA', // Introducing unconscious bias
  'http://cslearning.gov.uk/modules/KLRXA0JuQl2adwDkarL_MQ', // Unconscious bias in the workplace
  'http://cslearning.gov.uk/modules/a7Qob6rGTNO4lz-YwxcOPQ', // Unconscious bias in recruitment decisions
  'http://cslearning.gov.uk/modules/bhO67m7ORPuva29nEupw-w', // Tackling unconscious bias
  'http://cslearning.gov.uk/modules/VygMJPWJSKaJ-rL5ME1CEw', // Our inclusive workplace
  'http://cslearning.gov.uk/modules/yQZyWbp5To2Ur4tnsw-V0w', // Our customers
  'http://cslearning.gov.uk/modules/oEViFd7ARKyIWJUNuFiiug', // The legal framework
  'http://cslearning.gov.uk/modules/aryrmhLtQymHpWzhCmJWXg', // Government security classifications
  'http://cslearning.gov.uk/modules/iSX-vP86QbK1nc5AYy4Nqw', // Protecting and sharing information
  'http://cslearning.gov.uk/modules/ivlzc0WBRR2Z4u_NnFOzLQ', // In the workplace
  'http://cslearning.gov.uk/modules/g7xWtlauSnubswN2nFFkqQ', // Working flexibly
  'http://cslearning.gov.uk/modules/x5Usk-Z_S92ejgMaQYnbcQ', // Staying safe online
  'http://cslearning.gov.uk/modules/QJrXYisGQPOY0U2bOGIN6A', // Fraud
  'http://cslearning.gov.uk/modules/HRTQTChXQDS6Nu-00rtvdQ', // Managing information as an asset
  'http://cslearning.gov.uk/modules/fbHl0e3iT-afj_AOU3MQ4Q', // Mental health conditions and stigma
  'http://cslearning.gov.uk/modules/dma5v0c_QBKWatnnZ6Gp-g', // Looking out for each other
  'http://cslearning.gov.uk/modules/GYiWLxbiRcKrrFTOb6TUhw', // Mental health awareness quiz
  'http://cslearning.gov.uk/modules/ZTW2OnIkRTalu0Fwc7-GLA', //  Workplace scenarios tutorial open e-learning
  'http://cslearning.gov.uk/modules/zZVO2ge1R7uWomE_U11qJA', // Follow the money
  'http://cslearning.gov.uk/modules/lX1Phu-AT_GKktF1J40Ocg', // How finance works in your department
  'http://cslearning.gov.uk/modules/acoVIjRSTv2cv8-ogF_rSQ', // Staying accountable
  'http://cslearning.gov.uk/modules/F83eoCZpRk2uJuP5RLsJXg', //  Knowledge check
]
