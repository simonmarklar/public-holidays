import type { PageLoad } from './$types'

// eslint-disable-next-line @typescript-eslint/no-unused-vars
export const load: PageLoad = async ({ fetch, params }) => {
	const response = await fetch('api/public-holidays?year=2025')
	const holidays = await response.json() as {
		year: number
		states: string[]
		holidays: {
			year: number
			month: number
			day: number
			state: string
			holidayName: string
		}[]
	}
	return holidays
}
