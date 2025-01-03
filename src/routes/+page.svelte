<script lang="ts">
	import type { PageData } from './$types'

	let { data }: { data: PageData } = $props()

	let selectedState = $state('nsw')
	let numDaysLeave = $state(20)

	let holidays = $derived(
		data.holidays.filter((holiday: { state: string }) => holiday.state === selectedState)
	)
</script>

<h1>Plan my holidays</h1>

<div>
	<b>Year: </b> <span>{data.year}</span>
</div>

<form method="post">
	<label for="state">Your State:</label>
	<select name="state" bind:value={selectedState}>
		{#each data.states as state}
			<option value={state}>{state}</option>
		{/each}
	</select>
	<label for="numDaysLeave">How many days of leave do you have?</label>
	<input type="number" min="0" max="365" bind:value={numDaysLeave} />
</form>

<h1>Holidays in {selectedState.toLocaleUpperCase()} with {numDaysLeave} leave days</h1>

{#each holidays as holiday}
	<div>
		<span>{holiday.holidayName}</span> -
		<span>{holiday.day}/{holiday.month}/{holiday.year}</span>
	</div>
{/each}
