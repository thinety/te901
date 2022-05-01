def main():
    from l901 import L901


    print('----- 901 LOCAÇÕES -----')
    print('(utilitário de retirada)')
    print()

    with L901('db/.sqlite3') as l901:
        email = input('Digite o seu email: ')
        password = input('Digite a sua senha: ')
        print()

        employee = l901.login_employee(email=email, password=password)

        print(f'Seja bem vindo(a), {employee.name}\n')


        open_withdrawals = employee.get_open_withdrawals()

        if len(open_withdrawals) == 0:
            print('Não há retiradas a serem realizadas!')
            return

        print('Retiradas a serem realizadas:')
        for open_withdrawal in open_withdrawals:
            print(f'    {open_withdrawal.rental_id:2} - {open_withdrawal.client_name} ({open_withdrawal.vehicle_model})')

        rental_id = input('Indique o ID da retirada a ser realizada: ')
        rental_id = int(rental_id)

        print()


        remarks = input('Alguma observação? (anomalia no veículo ou quilometragem)\n')
        print()


        employee.withdrawal_vehicle(
           rental_id=rental_id,
           remarks=remarks,
        )


if __name__ == '__main__': main()
