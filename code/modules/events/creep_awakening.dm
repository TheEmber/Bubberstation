/datum/round_event_control/obsessed
	name = "Obsession Awakening"
	typepath = /datum/round_event/obsessed
	max_occurrences = 1
	min_players = 20
	category = EVENT_CATEGORY_HEALTH
	description = "A random crewmember becomes obsessed with another."

/datum/round_event/obsessed
	fakeable = FALSE

/datum/round_event/obsessed/start()
	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		if(!H.client || !(ROLE_OBSESSED in H.client.prefs.be_special) || !H.client.prefs?.read_preference(/datum/preference/toggle/be_antag))
			continue
		// BUBBER EDIT ADDITION BEGIN - Antag banned can't roll obsessed
		if(is_banned_from(H.client.ckey, list(ROLE_SYNDICATE, BAN_ANTAGONIST)))
			continue
		// BUBBER EDIT ADDITION END - Antag banned can't roll obsessed
		if(H.stat == DEAD)
			continue
		if(!(H.mind.assigned_role.job_flags & JOB_CREW_MEMBER)) //only station jobs sans nonhuman roles, prevents ashwalkers trying to stalk with crewmembers they never met
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/obsessed))
			continue
		if(!H.get_organ_by_type(/obj/item/organ/brain))
			continue
		H.gain_trauma(/datum/brain_trauma/special/obsessed)
		announce_to_ghosts(H)
		break
