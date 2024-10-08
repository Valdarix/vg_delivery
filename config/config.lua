Config = {}

Config.Debug = false

Config.Job = 'delivery'
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.VehicleModel = `boxville2`
Config.VehicleSpawn = vec4(62.22, 122.08, 79.06, 158.02)
Config.PedModel = `s_m_m_postal_02`
Config.PedLocation = vec4(78.73, 112.51, 80.17, 146.13)
Config.ClockOutWithoutTruck = true
Config.TipChance = 5
Config.MinPricePerPackage = 75
Config.MaxPricePerPackage = 150

Config.Locations = {   
    vec4(320.7, -1759.95, 29.64, 258.03),
    vec4(324.62, -1940.2, 25.02, 135.97),
    vec4(-271.62, 6399.32, 31.34, 208.46),
    vec4(281.98, -1694.96, 29.65, 38.42),
    vec4(416.94, -1733.81, 29.61, 141.85),
    vec4(-1469.13, 509.32, 117.61, 43.39),
    vec4(513.97, -1780.57, 28.91, 82.99),
    vec4(474.67, -1757.89, 29.09, 214.98),
    vec4(289.44, -1986.05, 21.23, 153.52),
    vec4(-236.3, 6421.28, 31.21, 207.88),
    vec4(9.69, 380.25, 112.28, 245.77),
    vec4(-730.97, 447.56, 106.9, 128.6),
    vec4(57.27, 450.0, 147.03, 333.84),
    vec4(-840.55, 453.95, 88.31, 96.64),
    vec4(213.73, 620.48, 187.43, 69.99),
    vec4(512.36, -1790.57, 28.92, 96.4),
    vec4(-771.06, 467.8, 100.18, 232.18),
    vec4(-300.41, 384.42, 110.82, 111.9),
    vec4(-584.7, 496.54, 107.1, 16.08),
    vec4(-1452.11, 539.67, 120.8, 181.94),
    vec4(-129.83, 6550.82, 29.52, 222.05),
    vec4(250.11, -1730.77, 29.67, 50.02),
    vec4(-595.79, 393.34, 101.88, 34.74),
    vec4(328.89, -1845.45, 27.75, 31.99),
    vec4(-653.76, 487.45, 109.75, 20.75),
    vec4(-1161.61, 561.46, 101.74, 263.47),
    vec4(384.91, -1881.66, 26.03, 233.04),
    vec4(-973.86, 585.06, 101.92, 357.63),
    vec4(-444.05, 344.79, 105.14, 12.59),
    vec4(-622.96, 400.87, 101.23, 93.38),
    vec4(-484.69, 408.85, 99.25, 99.79),
    vec4(1683.07, 4689.29, 43.07, 255.51),
    vec4(-32.77, -1447.15, 31.89, 186.9),
    vec4(-45.61, -1445.76, 32.43, 101.26),
    vec4(-1.85, -1448.33, 30.55, 161.5),
    vec4(-15.02, -1442.96, 31.1, 181.71),
    vec4(-477.51, 352.81, 104.15, 247.78),
    vec4(-232.73, 6383.07, 31.56, 42.07),
    vec4(282.66, -1899.35, 27.27, 60.21),
    vec4(1671.93, 4752.45, 41.86, 282.45),
    vec4(-494.95, 739.44, 163.03, 328.81),
    vec4(368.87, -1897.57, 25.18, 155.12),
    vec4(-210.29, 6445.17, 31.3, 185.66),
    vec4(-105.5, 6528.63, 30.17, 51.29),
    vec4(-409.43, 341.55, 108.91, 299.08),
    vec4(-516.65, 433.29, 97.81, 137.73),
    vec4(728.74, 2312.89, 51.75, 179.26),
    vec4(349.08, -1821.05, 28.89, 10.69),
    vec4(-877.11, 520.11, 91.9, 292.76),
    vec4(-1234.99, 493.51, 93.32, 198.65),
    vec4(-8.09, 6652.51, 31.11, 212.94),
    vec4(1535.82, 2231.69, 77.7, 86.99),
    vec4(-5.88, 469.8, 145.88, 312.7),
    vec4(-403.6, 6317.34, 28.94, 223.36),
    vec4(1723.84, 4641.68, 43.88, 115.71),
    vec4(-64.34, -1449.58, 32.53, 195.84),
    vec4(-28.28, 6599.03, 31.47, 42.01),
    vec4(231.49, 673.66, 189.94, 28.39),
    vec4(472.04, -1775.56, 29.07, 286.46),
    vec4(-40.07, 6637.1, 31.09, 223.98),
    vec4(15.99, -1445.13, 30.54, 149.46),
    vec4(105.9, 492.83, 147.15, 273.61),
    vec4(399.47, -1865.07, 26.72, 232.91),
    vec4(-924.66, 561.71, 99.95, 336.49),
    vec4(240.79, -1687.57, 29.7, 244.2),
    vec4(-1316.34, 454.25, 99.18, 355.1),
    vec4(-658.86, 898.42, 229.24, 344.66),
    vec4(-1146.58, 546.3, 101.51, 17.67),
    vec4(-371.65, 343.8, 109.94, 10.64),
    vec4(8.63, 541.26, 176.03, 336.56),
    vec4(-215.56, 6397.14, 33.08, 76.11),
    vec4(-1415.08, 463.98, 109.65, 341.88),
    vec4(-820.02, 428.38, 90.26, 334.97),
    vec4(222.55, 514.99, 140.74, 55.52),
    vec4(-904.67, 588.0, 101.19, 138.75),
    vec4(269.86, -1917.08, 26.18, 34.37),
    vec4(-303.3, 6328.62, 32.49, 56.79),
    vec4(489.48, -1714.67, 29.71, 290.59),
    vec4(-599.28, 861.03, 210.45, 332.79),
    vec4(-489.33, 797.35, 180.56, 256.39),
    vec4(-537.41, 478.33, 103.19, 63.89),
    vec4(1662.61, 4776.2, 42.01, 269.46),
    vec4(3312.92, 5175.28, 19.61, 235.3),
    vec4(443.57, -1707.21, 29.71, 52.56),
    vec4(256.15, -1723.88, 29.65, 41.86),
    vec4(-1107.48, 593.64, 104.45, 210.64),
    vec4(216.65, -1717.69, 29.68, 293.46),
    vec4(289.3, -1793.12, 28.09, 219.21),
    vec4(1718.17, 4674.95, 43.66, 186.01),
    vec4(-1192.09, 562.15, 100.34, 191.66),
    vec4(86.96, 482.17, 147.64, 286.07),
    vec4(413.21, -1856.86, 27.32, 278.19),
    vec4(84.94, 565.63, 182.11, 4.98),
    vec4(169.69, 483.19, 142.41, 287.61),
    vec4(102.9, 475.33, 147.41, 349.93),
    vec4(35.39, 6662.25, 32.19, 162.93),
    vec4(480.86, -1737.84, 29.15, 176.26),
    vec4(312.66, -1956.35, 24.63, 236.84),
    vec4(-1294.25, 454.85, 97.48, 10.41),
    vec4(333.01, -1743.4, 29.73, 154.0),
    vec4(294.37, -1973.09, 22.9, 267.58),
    vec4(1674.12, 4657.88, 43.37, 218.5),
    vec4(-195.79, 408.26, 111.11, 42.27),
    vec4(252.26, -1671.18, 29.66, 208.68),
    vec4(-59.37, 493.68, 144.69, 324.29),
    vec4(257.14, -1926.87, 25.44, 106.93),
    vec4(250.87, -1934.96, 24.7, 37.65),
    vec4(304.32, -1775.7, 29.1, 223.57),
    vec4(-875.31, 544.57, 92.65, 212.93),
    vec4(-684.44, 506.4, 110.29, 148.16),
    vec4(-762.56, 432.21, 100.05, 23.59),
    vec4(-1497.24, 437.51, 112.5, 54.21),
    vec4(49.26, 466.78, 147.42, 260.18),
    vec4(0.4, 6614.35, 31.88, 51.29),
    vec4(-188.83, 6409.71, 32.3, 39.39),
    vec4(-572.3, 402.88, 100.67, 148.98),
    vec4(427.63, -1842.45, 28.46, 231.47),
    vec4(-903.78, 548.9, 97.32, 66.64),
    vec4(-253.23, 396.95, 111.25, 99.01),
    vec4(-778.67, 451.27, 96.39, 222.92),
    vec4(-1022.87, 586.91, 103.43, 344.07),
    vec4(-359.22, 6333.9, 29.84, 220.0),
    vec4(-342.94, 368.16, 110.03, 112.0),
    vec4(-1126.56, 552.5, 102.31, 11.01),
    vec4(-1092.41, 550.68, 103.63, 16.99),
    vec4(-849.26, 509.79, 90.82, 34.99),
    vec4(500.13, -1698.01, 29.79, 150.73),
    vec4(471.06, 2607.52, 44.48, 347.58),
    vec4(-865.02, 467.99, 88.22, 186.92),
    vec4(-947.95, 567.99, 101.5, 336.54),
    vec4(-1539.78, 422.77, 110.01, 351.52),
    vec4(-548.17, 826.78, 197.51, 13.48),
    vec4(495.0, -1820.89, 28.87, 304.97),
    vec4(-280.72, 6350.8, 32.6, 51.07),
    vec4(-86.35, 426.04, 113.22, 131.33),
    vec4(222.17, -1702.84, 29.7, 218.2),
    vec4(-532.03, 708.13, 152.68, 200.23),
    vec4(430.99, -1725.67, 29.6, 45.83),
    vec4(441.5, -1830.74, 28.36, 182.59),
    vec4(405.36, -1750.94, 29.71, 60.04),
    vec4(-248.86, 6370.84, 31.48, 47.34),
    vec4(-433.83, 6270.75, 30.09, 249.01),
    vec4(-1263.55, 455.48, 94.77, 44.78),
    vec4(269.35, -1712.63, 29.67, 48.06),
    vec4(-178.83, 423.12, 110.74, 102.7),
    vec4(-1405.81, 530.0, 123.83, 9.08),
}

Config.Peds = {
    `a_f_m_bevhills_01`,
    `a_f_m_business_02`,
    -- `a_f_m_eastsa_01`,
    -- `a_f_m_downtown_01`,
    -- `a_f_m_eastsa_02`,
    -- `a_f_m_fatbla_01`,
    -- `a_f_m_fatwhite_01`,
    -- `a_f_m_ktown_01`,
    -- `a_f_m_ktown_02`,
    -- `a_f_m_salton_01`,
    -- `a_f_m_soucent_02`,
    -- `a_f_m_soucent_01`,
    -- `a_f_m_soucentmc_01`,
    -- `a_f_m_tramp_01`,
    -- `a_f_m_trampbeac_01`,
    -- `a_f_o_genstreet_01`,
    -- `a_f_o_indian_01`,
    -- `a_f_o_ktown_01`,
    -- `a_f_o_salton_01`,
    -- `a_f_y_bevhills_03`,
    -- `a_f_y_bevhills_02`,
    -- `a_f_y_bevhills_01`,
    -- `a_f_o_soucent_02`,
    -- `a_f_o_soucent_01`,
    -- `a_f_y_bevhills_04`,
    -- `a_f_y_business_02`,
    -- `a_f_y_clubcust_01`,
    -- `a_f_y_business_04`,
    -- `a_f_y_eastsa_01`,
    -- `a_f_y_eastsa_02`,
    -- `a_f_y_eastsa_03`,
    -- `a_f_y_epsilon_01`,
    -- `a_f_y_fitness_01`,
    -- `a_f_y_fitness_02`,
    -- `a_f_y_genhot_01`,
    -- `a_f_y_hiker_01`,
    -- `a_f_y_hippie_01`,
    -- `a_f_y_hipster_01`,
    -- `a_f_y_hipster_02`,
    -- `a_f_y_hipster_03`,
    -- `a_f_y_hipster_04`,
    -- `a_f_y_runner_01`,
    -- `a_f_y_rurmeth_01`,
    -- `a_f_y_soucent_01`,
    -- `a_f_y_soucent_02`,
    -- `a_f_y_vinewood_01`,
    -- `a_f_y_vinewood_02`,
    -- `a_f_y_vinewood_03`,
    -- `a_f_y_vinewood_04`,
    -- `a_m_m_eastsa_01`,
    -- `a_m_m_bevhills_01`,
    -- `a_m_m_bevhills_02`,
    -- `a_m_m_eastsa_02`,
    -- `a_m_m_genfat_01`,
    -- `a_m_m_golfer_01`,
    -- `a_m_m_rurmeth_01`,
    -- `a_m_m_skater_01`,
    -- `a_m_m_paparazzi_01`,
    -- `a_m_m_polynesian_01`,
    -- `a_m_m_indian_01`,
    -- `a_m_m_ktown_01`,
    -- `a_m_m_soucent_03`,
    -- `a_m_m_stlat_02`,
    -- `a_m_m_socenlat_01`,
    -- `a_m_m_trampbeac_01`,
    -- `a_m_o_soucent_02`,
    -- `a_m_y_beachvesp_01`,
    -- `a_m_y_beachvesp_02`,    

}