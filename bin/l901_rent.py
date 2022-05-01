def main():
    from datetime import datetime, timedelta

    from l901 import L901


    print('----- 901 LOCAÇÕES -----')
    print('(utilitário de aluguel)')
    print()

    with L901('db/.sqlite3') as l901:
        email = input('Digite o seu email: ')
        password = input('Digite a sua senha: ')
        print()

        client = l901.login_client(email=email, password=password)

        print(f'Seja bem vindo(a), {client.name}\n')


        categories = l901.get_categories()

        print('Categorias disponíveis:')
        for category in categories:
            print(f'    {category.id:2} - {category.code} ({category.description})')

        category_id = input('Indique o ID da categoria que deseja: ')
        category_id = int(category_id)

        print()


        vehicles = l901.get_vehicles(category_id=category_id)

        if len(vehicles) == 0:
            print('Não há veículos disponíveis nessa categoria!')
            return

        print('Veículos disponíveis:')
        for vehicle in vehicles:
            print(f'    {vehicle.id:2} - {vehicle.model} {vehicle.color}')

        vehicle_id = input('Indique o ID do veículo que deseja (0 para qualquer um): ')
        vehicle_id = int(vehicle_id)
        if vehicle_id == 0:
            vehicle_id = vehicles[0].id

        print()


        branches = l901.get_branches()

        print('Agências disponíveis:')
        for branch in branches:
            print(f'    {branch.id:2} - {branch.address}')

        withdrawal_branch_id = input('Indique o ID da agência onde deseja retirar: ')
        withdrawal_branch_id = int(withdrawal_branch_id)

        dropoff_branch_id = input('Indique o ID da agência onde deseja devolver: ')
        dropoff_branch_id = int(dropoff_branch_id)

        print()


        def parse_date_string(s):
            (day, month, year) = s.split('/')
            return datetime(int(year), int(month), int(day))

        expected_withdrawal_date = input('Indique a data que deseja retirar (formato DD/MM/AAAA): ')
        expected_withdrawal_date = parse_date_string(expected_withdrawal_date)

        expected_amount_of_days = input('Indique a quantidade de diárias que deseja: ')
        expected_amount_of_days = int(expected_amount_of_days)
        expected_dropoff_date = expected_withdrawal_date + timedelta(expected_amount_of_days)

        print()


        client.rent_vehicle(
            vehicle_id=vehicle_id,
            withdrawal_branch_id=withdrawal_branch_id,
            expected_withdrawal_date=expected_withdrawal_date,
            dropoff_branch_id=dropoff_branch_id,
            expected_dropoff_date=expected_dropoff_date,
        )


if __name__ == '__main__': main()
