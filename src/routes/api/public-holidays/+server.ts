import { error } from '@sveltejs/kit'
import type { RequestHandler } from './$types'
import holidays from './australian-public-hols-2021-2025.json'

export const GET: RequestHandler = ({ url }) => {
	const year = Number(url.searchParams.get('year') ?? '2025')

	if (isNaN(year) || year > 2025) {
		error(400, 'year must be a number less than 2025')
	}

	const data = {
		year,
		states: holidays
			.map((value) => value.state)
			.filter((value, index, self) => self.indexOf(value) === index),
		holidays: holidays.filter((value) => value.year === year)
	}

	return new Response(JSON.stringify(data))
}
