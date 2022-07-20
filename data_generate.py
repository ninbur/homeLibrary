import random
import re

genres_epic = ['powieść', 'nowela', 'opowiadanie', 'epopeja', 'baśń', 'mit', 'legenda', 'pamiętnik', 'przypowieść']
genres_lyric = ['oda', 'hymn', 'pieśń', 'tren', 'elegia', 'fraszka', 'epigramat', 'sonet']
genres_drama = ['dramat właściwy', 'tragedia', 'komedia', 'farsa', 'tragifarsa', 'opera']
genres_all = [genres_epic, genres_lyric, genres_drama]
genres_names_pl = ['epika', 'liryka', 'dramat']
genres_data = [{'genre_name': genres_all[j][i], 'type_name': genres_names_pl[j]} for j in range(len(genres_names_pl)) for i in range(len(genres_all[j]))]


rooms = ['1', '2', '3']

friends_data = [{'name_friend': 'Kacper Załężycki',
                 'phone': random.randint(100000000, 999999999), 'email':'kapi.z@gmail.com'},
                {'name_friend': 'Marta Wojnar',
                 'phone': random.randint(100000000, 999999999), 'email': 'martynka@wp.pl'},
                {'name_friend': 'Mama',
                 'phone': random.randint(100000000, 999999999), 'email': None},
                {'name_friend': 'Patrycja W.',
                 'phone': random.randint(100000000, 999999999), 'email': 'patwis@gmail.pl'},
                {'name_friend': 'Robert Markiewicz',
                 'phone': random.randint(100000000, 999999999), 'email': 'patlis@gmail.pl'}
                ]

purchase_places = ['Empik', 'Bonito', 'prezent', 'Matras', 'Świat Książki', 'Gandalf', 'Merlin', 'Tania książka',
                   'targi', 'OLX', 'Allegro', 'Antykwariat', 'Dedalus', 'Helion', 'Inverso', 'Tantis']

strn = '1. Afganistan 2. Albania 3. Algieria 4. Andora 5. Antigua i Barbuda 6. Arabia Saudyjska 7. Argentyna 8. Armenia 9. Australia 10. Austria 11. Azerbejdżan 12. Bahamy 13. Bahrajn 14. Bangladesz 15. Barbados 16. Belgia 17. Belize 18. Benin 19. Bhutan 20. Białoruś 21. Birma 22. Boliwia 23. Bośnia i Hercegowina 24. Botswana 25. Brazylia 26. Brunei 27. Bułgaria 28. Burkina Faso 29. Burundi 30. Chile 31. Chiny 32. Chorwacja 33. Cypr 34. Czad 35. Czarnogóra 36. Czechy 37. Dania 38. Demokratyczna Republika Konga 39. Dominika 40. Dominikana 41. Dżibuti 42. Egipt 43. Ekwador 44. Erytrea 45. Estonia 46. Etiopia 47. Fidżi 48. Filipiny 49. Finlandia 50. Francja 51. Gabon 52. Gambia 53. Ghana 54. Grecja 55. Grenada 56. Gruzja 57. Gujana 58. Gwatemala 59. Gwinea 60. Gwinea Bissau 61. Gwinea Równikowa 62. Haiti 63. Hiszpania 64. Holandia 65. Honduras 66. Indie 67. Indonezja 68. Irak 69. Iran 70. Irlandia 71. Islandia 72. Izrael 73. Jamajka 74. Japonia 75. Jemen 76. Jordania 77. Kambodża 78. Kamerun 79. Kanada 80. Katar 81. Kazachstan 82. Kenia 83. Kirgistan 84. Kiribati 85. Kolumbia 86. Komory 87. Kongo 88. Korea Południowa 89. Korea Północna 90. Kosowo 91. Kostaryka 92. Kuba 93. Kuwejt 94. Laos 95. Lesotho 96. Liban 97. Liberia 98. Libia 99. Liechtenstein Państwa świata – lista alfabetyczna (stan wg. ONZ 2013) 100. Litwa 101. Luksemburg 102. Łotwa 103. Macedonia 104. Madagaskar 105. Malawi 106. Malediwy 107. Malezja 108. Mali 109. Malta 110. Maroko 111. Mauretania 112. Mauritius 113. Meksyk 114. Mikronezja 115. Mołdawia 116. Monako 117. Mongolia 118. Mozambik 119. Namibia 120. Nauru 121. Nepal 122. Niemcy 123. Niger 124. Nigeria 125. Nikaragua 126. Norwegia 127. Nowa Zelandia 128. Oman 129. Pakistan 130. Palau 131. Panama 132. Papua-Nowa Gwinea 133. Paragwaj 134. Peru 135. Polska 136. Portugalia 137. Republika Południowej Afryki 138. Republika Środkowoafrykańska 139. Republika Zielonego Przylądka 140. Rosja 141. Rumunia 142. Rwanda 143. Saint Kitts i Nevis 144. Saint Lucia 145. Saint Vincent i Grenadyny 146. Salwador 147. Samoa 148. San Marino 149. Senegal 150. Serbia 151. Seszele 152. Sierra Leone 153. Singapur 154. Słowacja 155. Słowenia 156. Somalia 157. Sri Lanka 158. Stany Zjednoczone 159. Suazi 160. Sudan 161. Sudan Południowy 162. Surinam 163. Syria 164. Szwajcaria 165. Szwecja 166. Tadżykistan 167. Tajlandia 168. Tanzania 169. Timor Wschodni 170. Togo 171. Tonga 172. Trynidad i Tobago 173. Tunezja 174. Turcja 175. Turkmenistan 176. Tuvalu 177. Uganda 178. Ukraina 179. Urugwaj 180. Uzbekistan 181. Vanuatu 182. Watykan 183. Wenezuela 184. Węgry 185. Wielka Brytania 186. Wietnam 187. Włochy 188. Wybrzeże Kości Słoniowej 189. Wyspy Marshalla 190. Wyspy Salomona 191. Wyspy Świętego Tomasza i Książęca 192. Zambia 193. Zimbabwe 194. Zjednoczone Emiraty Arabskie'
strn = re.sub('(\d+).', '-', strn).split('-')[1:]
countries_author = list(map(lambda x: x.lstrip(), strn))

cities_publisher = ['Warszawa', 'Wrocław', 'Kraków', 'Gdańsk', 'Łódź', 'Poznań', 'Nowy York', 'Londyn', 'Paryż']
