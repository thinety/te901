def main():
    from datetime import datetime

    from l901 import L901, calculate_extra_hours


    print('----- 901 LOCAÇÕES -----')
    print('(utilitário de devolução)')
    print()

    with L901('db/.sqlite3') as l901:
        email = input('Digite o seu email: ')
        password = input('Digite a sua senha: ')
        print()

        employee = l901.login_employee(email=email, password=password)

        print(f'Seja bem vindo(a), {employee.name} ({employee.role[1]}', end='')
        if employee.branch is not None:
            print(f' na agência {employee.branch[1]}', end='')
        print(')\n')


        open_dropoffs = employee.get_open_dropoffs()

        if len(open_dropoffs) == 0:
            print('Não há devoluções a serem realizadas!')
            return

        print('Devoluções a serem realizadas:')
        for open_dropoff in open_dropoffs:
            print(f'    {open_dropoff.rental_id:2} - {open_dropoff.client_name} ({open_dropoff.vehicle_model})')

        rental_id = input('Indique o ID da devolução a ser realizada: ')
        rental_id = int(rental_id)

        print()


        remarks = input('Alguma observação? (anomalia no veículo ou quilometragem)\n')
        print()


        dropoff_info = employee.get_dropoff_info(rental_id=rental_id)
        dropoff_date = datetime.now()
        extra_hours = calculate_extra_hours(
            dropoff_info.expected_withdrawal_date,
            dropoff_info.expected_amount_of_days,
            dropoff_info.withdrawal_date,
            dropoff_date,
        )
        price = dropoff_info.daily_price * dropoff_info.expected_amount_of_days

        print(f'Data de retirada marcada: {dropoff_info.expected_withdrawal_date.day:02}/{dropoff_info.expected_withdrawal_date.month:02}/{dropoff_info.expected_withdrawal_date.year:04}')
        print(f'Número de diárias: {dropoff_info.expected_amount_of_days}\n')

        print(f'Data de retirada: {dropoff_info.withdrawal_date.day:02}/{dropoff_info.withdrawal_date.month:02}/{dropoff_info.withdrawal_date.year:04} {dropoff_info.withdrawal_date.hour:02}:{dropoff_info.withdrawal_date.minute:02}:{dropoff_info.withdrawal_date.second:02}')
        print(f'Data de devolução: {dropoff_date.day:02}/{dropoff_date.month:02}/{dropoff_date.year:04} {dropoff_info.withdrawal_date.hour:02}:{dropoff_info.withdrawal_date.minute:02}:{dropoff_info.withdrawal_date.second:02}\n')

        print(f'Preço da diária: R$ {dropoff_info.daily_price:.2f}')
        print(f'Subtotal: R$ {price:.2f}\n')

        if extra_hours > 0:
            penalty = 0.2 * dropoff_info.daily_price * extra_hours
            price += penalty

            print(f'Horas de atraso na devolução: {extra_hours}')
            print(f'Multa (20% da diária por hora de atraso): R$ {penalty:.2f}\n')

        extra_cost = input('Custo extra: ')
        extra_cost = float(extra_cost)

        print()

        price += extra_cost

        print(f'Total: R$ {price:.2f}\n')


        employee.dropoff_vehicle(
            rental_id=rental_id,
            date=dropoff_date,
            remarks=remarks,
            price=price,
        )


if __name__ == '__main__': main()
