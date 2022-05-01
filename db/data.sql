-- all passwords are '123'

INSERT INTO client (email, phc_string, name, telephone, address, cpf, cnh) VALUES
    ('albertoo@gmail.com',           '$scrypt$ln=14,r=8,p=1$XQJr7/8kQF2uoQpjXn51fWqNooRLS7lC$Cr7ir+g9Q9BXLo6MkJF+V1bXtdMIqm4l57njFtVIyQdg6HFlkKLI4Ih57YU5qc5Y', 'Alberto Oliveira',          '+55 45 3651 3951', 'Avenida dos Pássaros, 32, Vila Georgina, Curitiba - PR',                   '82484216947', '11894424901'),
    ('amandaas@gmail.com',           '$scrypt$ln=14,r=8,p=1$fobtlwg5/QpjZzjLPQ8424g6OYoxjSbx$6ij/PmclXgFOPiwAwsouv4hEDzdgE129iTMqnrWLsVlftmrnhlSVtJtDA2YZvthl', 'Amanda Aparecida Silva',    '+55 46 3843 8517', 'Rua João Gonçalves Padilha, 93, Roseira, Londrina - PR',                   '73128423997', '25989579750'),
    ('lucianafo@gmail.com',          '$scrypt$ln=14,r=8,p=1$zgt4Dfc4XFXVoSeIBq75kGX0hXm2ihhV$La7IrP7gkDQdutp9Ut2sHaMh0CxgatbqpwWmd8EvAxy58zbk58K9S1gIdVenwxvW', 'Luciana Fabricia Oliveira', '+55 43 2322 2715', 'Rua Cláudio Chatagnier, 89, Bacacheri, Curitiba - PR',                     '94214976940', '67627608085'),
    ('andreiaa@gmail.com',           '$scrypt$ln=14,r=8,p=1$poZOyFJqsIark0HuMEs+TxmYNqKLdAYs$APP5v6dIbbsFJa6QvB1Cccp6rvJwH+T2ecNQfG4e/Nf8rmGX4BGjyqgWFCeJY2hB', 'Andreia Abulquerque',       '+55 44 3516 9838', 'Servidão Antônio Tiago Nunes, 3, São João do Rio Vermelho, Londrina - PR', '41389482952', '91133441160'),
    ('felipess@gmail.com',           '$scrypt$ln=14,r=8,p=1$y47q9Y8YPbQoo9Ac0FvQ5XvahxIqouhu$M4bXTdniJfZnF5P5WO0YpVbdV7gshaIfnInpIsoRPugCUqRy+Oe8PbP/5ILEfU/O', 'Felipe Souza Santos',       '+55 44 3198 6564', 'Rua Rio Grande do Sul, 432, Jardim Porto Alegre, Ponta Grossa - PR',       '63075578932', '09052824266'),
    ('andremjr@gmail.com',           '$scrypt$ln=14,r=8,p=1$RdhW9o0oKuxDqyFu2Eolu6aa6K/2tx9C$sA0fUTpXGyypym0DmLw/RNnQpYxBcjWDprUP1BxQ2JaftVZ7MbHFUTFqFY3/IoyX', 'André Miosli Jr',           '+55 45 3435 7641', 'Rua Manacá, 42, Jardim Karla, Pinhais - PR',                               '69714071992', '93642986332'),
    ('andersonpa@gmail.com',         '$scrypt$ln=14,r=8,p=1$pHCA86Y1/n4JBt33J/nOYquEnHegbdVX$r6J9FU8CjGyLQQSX7FDTDTOzRbv9WDtyRyHbAVC6uj4MDfpYHMKFCpu6KYiVTf2E', 'Anderson Pereira Andrade',  '+55 46 2026 7465', 'Rua Rio Iguaçu, 294, Roça Grande, Colombo - PR',                           '25780878900', '59325747860'),
    ('anapaulaso@gmail.com',         '$scrypt$ln=14,r=8,p=1$EgYUtbDJOWRN1xtlM2kv/Ro27OSgnCP2$452+OD5yUW3RcW/od8UeGndc/8SC5EmUQDM+BDMAA3astGL/YbViiyRAHJtegFVE', 'Ana Paula Siqueira',        '+55 43 2817 9271', 'Rua Isaías de Noronha, 214, Parque Presidente, Londrina - PR',             '45831380912', '74913478345'),
    ('gustavohu@gmail.com',          '$scrypt$ln=14,r=8,p=1$Zya/3YWiW0GMfdbz0aBgXGA2MK/IU66W$LQW0A673+HFjtJqispH9lPkvWZCgILpbfqPAMVt6qlxWEQBkvbw2wUjAHFDU5Btp', 'Gustavo Henrique Urich',    '+55 42 3262 4839', 'Estrada da Ilha, 83, Pirabeiraba, Joinville - SC',                         '13430335949', '03132607868'),
    ('lucasfo@outlook.com',          '$scrypt$ln=14,r=8,p=1$byQb/MzTAggQ9KsUrIwmWJ5mWu8d702W$NMgF6WjEFYSEzS7zPOVYtBgD2m5tCqt0gAoAaGoxCYgoLhk2pDqTbHBHQJVdN93H', 'Lucas Felipe Oioshi',       '+55 41 3266 5602', 'Rua Arnoldo Bastos, 83, Centro, Camboriú - SC',                            '28838135908', '95771660617'),
    ('mariael@outlook.com',          '$scrypt$ln=14,r=8,p=1$nlvIP/gy8lzlCFqEsUQFMz7Gof2p+qgL$3aoIWmRwYxgJodKIvzcEPuYUMUeuon9oJcyy4wHd8XrCnqSYrqOqw/lF1smeGlkt', 'Maria Eduarda Lima',        '+55 44 3716 7485', 'Rua Hermann Hering, 398, Bom Retiro, Blumenau - SC',                       '24876701938', '79295128345'),
    ('mariaclararequit@outlook.com', '$scrypt$ln=14,r=8,p=1$+ev6Uz/46hy5GgZdH3R78X9nxgotonob$c+D8ndchrPJ06Q3/rmGDbAoRssdcLR6pPgJA2yEUzf3NWpyD5bAWuNP77hvdvMdt', 'Maria Clara Requit',        '+55 42 2950 3605', 'Travessa Borba Gato, 45, Bela Vista, Ponta Grossa - PR',                   '28181255968', '29926354762'),
    ('camilacristianc@outlook.com',  '$scrypt$ln=14,r=8,p=1$F6qcuV0/RyeV6I94chbMkaiIu/SzbQK9$Iul+5OnOdbsrKrJ13NWAatijH2BRyygpODCLBZfEMFM3Xn7yfGqAvixD619tzzIe', 'Camila Cristian Camargo',   '+55 42 2286 8310', 'Beco Aracy Margarida de Abreu, 23, Centro, Florianópolis - SC',            '72519725907', '36684719911'),
    ('marianoa@outlook.com',         '$scrypt$ln=14,r=8,p=1$hqwahr0dHMzkt7gDjCoHpwpqLgSey36G$gK4pCpI0bPxyS/sjmfB1NVOlise2xrdvodvrlovAFTLwSzTsdOkEMgcZr71NgmiI', 'Mariano Areosa',            '+55 41 3463 7596', 'Rua Palhoça, 210, Bom Retiro, Colombo - PR',                               '03382465922', '82836045829'),
    ('emanuellelm@outlook.com',      '$scrypt$ln=14,r=8,p=1$KaMxHv5oiI6ZmbOmcHmJcyvcNoGgyfb7$7vZ0cvHJcihJqtr9Xgy2ywBMDE8xm+Za+82qIJ6E9Lcm0kKfG/H0O5d8KNOMDsio', 'Emanuelle Luara Matias',    '+55 45 3685 3021', 'Rua João Saturnino Justino da Silva, 32, Rio Maina, Londrina - PR',        '95275696990', '46123461006');

INSERT INTO branch (id, address) VALUES
    (1, 'Jardim das Américas - Curitiba - PR'),
    (2, 'Centro - Curitiba - PR'),
    (3, 'Santa Felicidade - Curitiba - PR'),
    (4, 'Portão - Curitiba - PR'),
    (5, 'Aeroporto Internacional Afonso Pena - São José dos Pinhais - PR'),
    (6, 'Londrina - PR'),
    (7, 'Ponta Grossa - PR'),
    (8, 'Joinville - SC'),
    (9, 'Blumenau - SC');

INSERT INTO employee_role (id, description) VALUES
    (1, 'atendente'),
    (2, 'gerente'),
    (3, 'diretor');

INSERT INTO employee (id, email, phc_string, name, telephone, address, cpf, cnh, role_id) VALUES
    (1,  'lianev@901locacoes.br',      '$scrypt$ln=14,r=8,p=1$sNuH9gq8mDWrkjc+NREijEReZQq/2hAR$fUIY1+yMVNCl/yBorEgvzUat8mUrzNVp3fok7VNmS+9mrTMUlSURP0STmL0CCThC', 'Liane Velasques',        '+55 42 2445 4528', 'Rua Gilberto Haliski, 332, Capela Velha, Curitiba - PR',                        '52740790910', '27132758801', 1),
    (2,  'victoriav@901locacoes.br',   '$scrypt$ln=14,r=8,p=1$hnIrw9E1QpQNFo+o+yY/Be/jmZQK9VYc$yC616uzS1X1pZHxdHmJFYOfJRn6AXCFEV1tt1XON/AFkgMe0618YBBObgr5DQOhX', 'Victoria Vidal',         '+55 41 2561 4584', 'Travessa Croácia, 101, Nações, Curitiba - PR',                                  '33114332978', '14269814910', 1),
    (3,  'sophiem@901locacoes.br',     '$scrypt$ln=14,r=8,p=1$8Gw/doc6JGdb2CBk8lb5Ajpg+eJtKCAj$iLnVnToMNKSJKhLkIU2zH+Ot0fCbnrIHt2SdnNC/QPwQHy5ieUga/lchq+04juwF', 'Sophie Moreira ',        '+55 43 3965 6628', 'Rua das Pitangueiras, 12, Jardim Guaíra, Curitiba - PR',                        '03340218986', '35179485020', 1),
    (4,  'alexb@901locacoes.br',       '$scrypt$ln=14,r=8,p=1$njKij3u4hlpMGWFo/CM/8Qf6mOUPCXi6$rM7kYPceEiQzYe9i5bNr00qLk7FTaINBR+cxpCe+RGfDql4DZ19fvM5Md3mT9WXk', 'Alex Barroca',           '+55 42 3451 4564', 'Rua Criciúma, 29, João Pessoa, Curitiba - PR',                                  '12352005906', '78243101873', 1),
    (5,  'hamiltona@901locacoes.br',   '$scrypt$ln=14,r=8,p=1$7Tmi9JCcvsVmquLQyH39WiWeGlnIb0BJ$Myw2oTGuDR0SXf4LT5NmktYdLBMSoh+zfDrDbg3GCRkPr2jAeqlGaWEUpkmn0fNk', 'Hamilton Alcaide',       '+55 45 2818 4259', 'Rua Irmão Leão Magno, 87, Amizade, Pinhais - PR',                               '36688699958', '97351538185', 1),
    (6,  'katiarf@901locacoes.br',     '$scrypt$ln=14,r=8,p=1$2DhmnaB2sbF4zX+bdHucNyS/CHZ2Rrp/$YLRgNlxL4/arDz6XIuCCf2B9ICYrVDxqwSx3Pa0fNNeNC0GL/ws3TuiRQA0D5B5e', 'Katia Renata Flora',     '+55 46 2715 5558', 'Rua Severino Fávero, 64, Dois Pinheiros, Londrina - PR',                        '26627827905', '14751297865', 1),
    (7,  'juliocp@901locacoes.br',     '$scrypt$ln=14,r=8,p=1$aUlHvISjVCYki0mAv1/VE17jxbXmYxqY$kXSCGlrucvhkcfHkSavC5UPNZKWVJWyalw/P76EsKvnWkaIwzw2SHk7bMYRca+rF', 'Julio Cesar Pires',      '+55 43 3222 6754', 'Rua Ferreira Viana, 421, Uvaranas, Ponta Grossa - PR',                          '28801296991', '12947250491', 1),
    (8,  'anaclaudias@901locacoes.br', '$scrypt$ln=14,r=8,p=1$1kClEpYrdxB7ShxRrjRnP229u/EXk2CY$d+PGJBKXmq7OX72YRl91Vq0qSL29ngEafhjBc+Wy9R+N3DHT6dn4/E8ybhorQ67n', 'Ana Claudia Silva',      '+55 42 2838 6189', 'Rua Cristiano Lueders, 5, Glória, Joinville - SC',                              '71191488934', '21014266796', 1),
    (9,  'beatriz@901locacoes.br',     '$scrypt$ln=14,r=8,p=1$bWfKj3IOM8s51nT4powt/1GjVn5w4lMz$rBZS+spB0EAbODY/VidyOdh9VC8z3W0FiVt/pHCDkgnUrHPkGT9eInuDtNXWaio6', 'Beatriz Xavier Pereira', '+55 42 3708 5140', 'Rua José Antônio Voltolini, 53, Itoupava Norte, Blumenau - SC',                 '37410598972', '90876564136', 1),
    (10, 'selmaf@901locacoes.br',      '$scrypt$ln=14,r=8,p=1$Egq9SAw4DP4RPYFsajcQfjacOE51MIL6$thqzZ2SoiMA8VMeWJePvxPECj3UEC4spF/r/pcGGnQd0zoCfWcd5R3rLXpChEC2q', 'Selma Ferraço',          '+55 44 2875 7065', 'Jardinete Deputado Ladislau Lachowski, 290, Vista Alegre, Curitiba - PR',       '47815611958', '74555318510', 2),
    (11, 'mayarac@901locacoes.br',     '$scrypt$ln=14,r=8,p=1$K9VgkO1Wxq7GEQS3G6sLrN5ZsBR3sQxH$uCjo9mBp+DgyMVQGuu8QEK4DjBOSgHViA00exGEaQ+7+Rj72RTwdj7Gbf2vUyhiC', 'Mayara Cunha',           '+55 42 2617 2611', 'Rua Pescador Domingos Luiz Costa, 55, Ingleses do Rio Vermelho, Londrina - PR', '87936986901', '45924691816', 2),
    (12, 'janilsonv@901locacoes.br',   '$scrypt$ln=14,r=8,p=1$76z0MbB1LnyYKmnWNK2gy1eqTX/9YzYK$EMYE6vNrQE2iPpCrgV5ymStu2Y71uhebp8fRUflDMYsYFHmDr1sF1iqBk0cPKcDM', 'Janilson Velasques',     '+55 46 3348 4385', 'Rua Frontino Antônio Floriano, 2, São Sebastião, Ponta Grossa - PR',            '44197203950', '20524154687', 2),
    (13, 'luissc@901locacoes.br',      '$scrypt$ln=14,r=8,p=1$aNxgd8v6Qiif7Nns+9XfTXnWhM4wnctI$WkWRQqSQR63MEJ6QMyu73UHFwIargcFrP8uGa2TBh4GSL9dYDD/fWoKWM7OfJOUO', 'Luis Santarém Charneca', '+55 42 3057 3964', 'Rua Abelino Abdon Ferreira, 12, Itaum, Joinville - SC',                         '29288306935', '19866975618', 2),
    (14, 'ilidioc@901locacoes.br',     '$scrypt$ln=14,r=8,p=1$40JicCHp79M6FWJzswl7OXXb6MXeGsrO$1GWNF0TasTrAMwjIvIgALFbE1EdDSMDdbCm6BrZj/+J4RZyPC1MAgQVBx6+fqQxw', 'Ilídio Chamusca',        '+55 41 2907 7351', 'Rua Afonso Lucio Pereira, 9, Serra Alta, Curitiba - PR',                        '90095104925', '28649348137', 3),
    (15, 'arminiol@901locacoes.br',    '$scrypt$ln=14,r=8,p=1$ujbz54y9BTGY+9G5/lGk1LTPsnYSNI57$VyAp/OTVlXM8/I2F9ihttUbqIwfRFS0e4ZcbJFPonTaxWyB9keVQbzuFFsSVQftC', 'Armindo Leitão ',        '+55 44 3744 1009', 'Rua José João Barcelos, 40, João Costa, Joinville - SC',                        '43346449963', '98590542832', 3);

INSERT INTO employee_branch (employee_id, branch_id) VALUES
    ( 1, 1),
    ( 2, 2),
    ( 3, 3),
    ( 4, 4),
    ( 5, 5),
    ( 6, 6),
    ( 7, 7),
    ( 8, 8),
    ( 9, 9),
    (10, 2),
    (11, 6),
    (12, 7),
    (13, 8);

INSERT INTO vehicle_category (id, code, description, price) VALUES
    (1, 'E1', 'Compacto',               14602),
    (2, 'E2', 'Econônico com ar',       16728),
    (3, 'E3', 'Econômico completo',     17153),
    (4, 'S1', 'Econômico sedan com ar', 17472);

INSERT INTO vehicle (model, color, plate, renavam, category_id, branch_id) VALUES
    ('Fiat Mobi',        'cinza',    'HZI8546', '31389461598', 1, 1),
    ('Renault Kwid',     'branco',   'KJO0972', '92222785197', 1, 5),
    ('Renault Sandero',  'branco',   'HQB7524', '51270925770', 2, 8),
    ('Chevrolet Joy',    'preto',    'JZQ8641', '17875833700', 2, 4),
    ('Volkswagen Gol',   'vermelho', 'KBZ0104', '45911805214', 2, 6),
    ('Fiat Argo',        'prata',    'HPZ3509', '22881713695', 3, 7),
    ('Chevrolet Onix',   'cinza',    'NES2712', '30720784036', 3, 8),
    ('Hyundai HB20',     'branco',   'LBC5708', '52459690135', 3, 2),
    ('Renault Logan',    'prata',    'MOJ5827', '99296266930', 4, 3),
    ('Hyundai HB20S',    'prata',    'MUF3326', '84948277280', 4, 1),
    ('Chevrolet Prisma', 'preto',    'IPU8746', '22156284708', 4, 8);
