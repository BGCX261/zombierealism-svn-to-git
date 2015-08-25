#define KIT_SUP \
			setdvar kit_type "support"; \
			setdvar w_text "M1 Garand"; \
			setdvar w_text_sec "Colt M1911"; \
			setdvar w_text_att ""; \
			setdvar w_text_inv ""; \
			setdvar w_text_gr_prim ""; \
			setdvar primary "weapon_m1garand"; \
			setdvar primary_attachment ""; \
			setdvar secondary "weapon_colt"; \
			setdvar inventory ""; \
			setdvar grenade_primary "" \
			setdvar show_primary "1" \
			setdvar show_primary_attachment "1" \
			setdvar show_secondary "1" \
			setDvar support_locked "1";\
			setdvar show_bolts "1"; \
			setdvar show_rifles "1"; \
			setdvar show_subs "0"; \
			setdvar show_shots "0"; \
			setdvar show_mgs "1";\

#define KIT_SOL \
			setdvar kit_type "soldier"; \
			setdvar w_text "M1A1 Carbine"; \
			setdvar w_text_sec "Colt M1911"; \
			setdvar w_text_att ""; \
			setdvar w_text_inv ""; \
			setdvar w_text_gr_prim ""; \
			setdvar primary "weapon_m1carbine"; \
			setdvar primary_attachment ""; \
			setdvar secondary "weapon_colt"; \
			setdvar inventory ""; \
			setdvar grenade_primary ""; \
			setdvar show_primary "1"; \
			setdvar show_primary_attachment "1"; \
			setdvar show_secondary "1"; \
			setdvar show_inventory "1"; \
			setDvar soldier_locked "1";\
			setdvar show_bolts "1"; \
			setdvar show_rifles "1"; \
			setdvar show_subs "1"; \
			setdvar show_shots "0"; \
			setdvar show_mgs "0";\
			
#define KIT_ENG \
			setdvar kit_type "engineer"; \
			setdvar w_text "Kar98k"; \
			setdvar w_text_sec "Colt M1911"; \
			setdvar w_text_att ""; \
			setdvar w_text_inv ""; \
			setdvar w_text_gr_prim ""; \
			setdvar primary "weapon_kar98k"; \
			setdvar primary_attachment ""; \
			setdvar secondary "weapon_colt"; \
			setdvar inventory ""; \
			setdvar grenade_primary ""; \
			setdvar show_primary "1"; \
			setdvar show_primary_attachment "1"; \
			setdvar show_secondary "1"; \
			setdvar show_inventory "1"; \
			setDvar engineer_locked "1";\
			setdvar show_bolts "1"; \
			setdvar show_rifles "1"; \
			setdvar show_subs "0"; \
			setdvar show_shots "1"; \
			setdvar show_mgs "0";\
			
#define KIT_MED \
			setdvar kit_type "medic"; \
			setdvar w_text "Gewehr 43"; \
			setdvar w_text_sec "Colt M1911"; \
			setdvar w_text_att ""; \
			setdvar w_text_inv ""; \
			setdvar w_text_gr_prim ""; \
			setdvar primary "weapon_gewehr43"; \
			setdvar primary_attachment ""; \
			setdvar secondary "weapon_colt"; \
			setdvar inventory ""; \
			setdvar grenade_primary ""; \
			setdvar show_primary "1"; \
			setdvar show_primary_attachment "1"; \
			setdvar show_secondary "1"; \
			setdvar show_inventory "1"; \
			setDvar medic_locked "1";\
			setdvar show_bolts "1"; \
			setdvar show_rifles "1"; \
			setdvar show_subs "1"; \
			setdvar show_shots "0"; \
			setdvar show_mgs "0";\
			
#define KIT_CUS \
			setdvar kit_type "custom"; \
			setdvar w_text "Gewehr 43"; \
			setdvar w_text_sec "Colt M1911"; \
			setdvar w_text_att ""; \
			setdvar w_text_inv ""; \
			setdvar w_text_gr_prim ""; \
			setdvar primary "weapon_gewehr43"; \
			setdvar primary_attachment ""; \
			setdvar secondary "weapon_colt"; \
			setdvar inventory ""; \
			setdvar grenade_primary ""; \
			setdvar show_primary "1"; \
			setdvar show_primary_attachment "1"; \
			setdvar show_secondary "1"; \
			setdvar show_inventory "1"; \
			setdvar show_bolts "1"; \
			setdvar show_rifles "1"; \
			setdvar show_subs "1"; \
			setdvar show_shots "1"; \
			setdvar show_mgs "1";\
			
#undef CHOICE_POPMENU_TITLE
#define CHOICE_POPMENU_TITLE( textArg ) \
		itemDef \
		{ \
			type			ITEM_TYPE_BUTTON \
			rect			92 145 200 CHOICE_POPUP_TITLE_HEIGHT HORIZONTAL_ALIGN_LEFT VERTICAL_ALIGN_TOP \
			exp				text(textArg); \
			textfont		CHOICE_TEXTFONT \
			textscale		CHOICE_POPUP_TITLE_TEXTSIZE \
			textAlign		ITEM_ALIGN_MIDDLE_LEFT \
			textstyle		CHOICE_TEXTSTYLE \
			forecolor		CHOICE_TEXTCOLOR \
			visible			1 \
			decoration \
		} \

#define HIDE_W \
	setdvar show_primary "0" \
	setdvar show_secondary "0" \
	setdvar show_inventory "0" \
	setdvar show_perk_1 "0" \
	setdvar show_perk_2 "0" \
	setdvar show_perk_3 "0" \

#define SHOW_W \
	setdvar show_primary "1" \
	setdvar show_secondary "1" \
	setdvar show_inventory "1" \
	setdvar show_perk_1 "1" \
	setdvar show_perk_2 "1" \
	setdvar show_perk_3 "1" \

#define PREPROC_SHADER_DRAW_ALIGNED( prect, porigin, pshader, pcolor, pborder, pbordersize, pbordercolor ) \
		itemDef { \
			style			WINDOW_STYLE_SHADER \
			rect			prect \
			origin 			porigin \
			forecolor		pcolor \
			exp				material( pshader ); \
			border			pborder \
			bordersize		pbordersize \
			bordercolor		pbordercolor \
			visible			1 \
			decoration \
		}

#define CHOICE_BUTTON_FOCUS_VIS_NOHI2( itemIndex, textArg, actionArg, onFocusArg, leaveFocusArg, visArg ) \
		itemDef \
		{ \
			type			ITEM_TYPE_BUTTON \
			rect			CHOICE_RECT( itemIndex ) \
			exp				text( textArg ); \
			textfont		CHOICE_TEXTFONT \
			textscale		CHOICE_TEXTSIZE \
			textstyle		CHOICE_TEXTSTYLE \
			textAlign		CHOICE_TEXTALIGN \
			textAlignX		CHOICE_TEXT_OFFSET_X \
			forecolor		CHOICE_TEXTCOLOR \
			visible			visArg \
			CHOICE_SCRIPTS_ALL( itemIndex, actionArg, onFocusArg, leaveFocusArg ) \
		} \

#define SHADER_DRAW( px, py, pw, ph, pshader, pcolor, visArg ) \
itemDef { \
	style			WINDOW_STYLE_SHADER \
	rect		 	px py pw ph HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN \
	forecolor		pcolor \
	exp				material( pshader ); \
	visible			visArg decoration }
	
#define WEAPON_PERK1 \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			origin			275 203 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text_perk2) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.3 \
			visible 		when(dvarint(show_perk2) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_PERK_MAIN1 \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			395 384 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(m_text_perk1) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.3 \
			visible 		when(dvarint(show_perk_1) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_PERK_MAIN2 \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			395 419 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(m_text_perk2) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.3 \
			visible 		when(dvarint(show_perk_2) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_PERK_MAIN3 \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			395 454 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(m_text_perk3) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.3 \
			visible 		when(dvarint(show_perk_3) >= 1 ) \
			decoration \
		} \

#define WEAPON_PRIMARY \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			362 53 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_primary) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_PRIMARY_ATT \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			450 53 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text_att) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_primary_attachment) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_PRIMARY2 \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			335 195 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text2) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_primary2) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_PRIMARY_ATT2 \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			546 53 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text_att2) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_primary_attachment2) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_SECONDARY \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			362 173 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text_sec) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_secondary) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_SECONDARY2 \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			362 195 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text_sec2) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_secondary2) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_INVENTORY \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			362 258 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text_inv) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_inventory) >= 1 ) \
			decoration \
		} \
		
#define WEAPON_GRENADE_SECONDARY \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			365 425 \
			forecolor		COLOR_TITLE \
			exp text ( dvarString(w_text_gr_sec) ); \
			textfont		UI_FONT_NORMAL \
			textscale		.4 \
			visible 		when(dvarint(show_gr_sec) >= 1) \
			decoration \
		} \

#define HIGHLIGHT_2( itemIndex, foreColorArg, borderColorArg, visArg ) \
		itemDef \
		{ \
			style			WINDOW_STYLE_SHADER \
			rect			CHOICE_ORIGIN( itemIndex ) (CHOICE_SIZE_X-(CHOICE_SIZE_Y/4)) CHOICE_SIZE_Y CHOICE_HORIZONTAL_ALIGN CHOICE_VERTICAL_ALIGN \
			background		"menu_button_backing_highlight" \
			forecolor		foreColorArg \
			border			HIGHLIGHT_BORDER \
			bordersize		2 \
			bordercolor		borderColorArg \
			visible			visArg \
			decoration \
		} \
		
#define STYLE_SETUP3 \
		itemDef \
		{ \
			style			WINDOW_STYLE_FILLED \
			rect			0 0 640 480 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN \
			backcolor		0 0 0 1 \
			visible			1 \
			decoration \
		} \
		itemDef \
		{ \
			name top_gradient \
			style			WINDOW_STYLE_FILLED \
			rect			0 0 854 30 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .2 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line1 \
			style			WINDOW_STYLE_FILLED \
			rect			0 30 854 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line2 \
			style			WINDOW_STYLE_FILLED \
			rect			350 150 600 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name bottom_gradient \
			style			WINDOW_STYLE_FILLED \
			rect			0 600 854 30 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .2 \
			visible			1 \
			decoration \
		} \
		itemDef \
		{ \
			name vertical_line1 \
			style			WINDOW_STYLE_FILLED \
			rect			350 0 1 800 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		
#define STYLE_SETUP2 \
		itemDef \
		{ \
			style			WINDOW_STYLE_FILLED \
			rect			0 0 640 480 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN \
			backcolor		0 0 0 1 \
			visible			1 \
			decoration \
		} \
		itemDef \
		{ \
			name top_gradient \
			style			WINDOW_STYLE_FILLED \
			rect			0 0 854 30 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .2 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line1 \
			style			WINDOW_STYLE_FILLED \
			rect			0 30 854 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line2 \
			style			WINDOW_STYLE_FILLED \
			rect			350 150 600 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line3 \
			style			WINDOW_STYLE_FILLED \
			rect			350 240 600 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line4 \
			style			WINDOW_STYLE_FILLED \
			rect			350 326 600 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line5 \
			style			WINDOW_STYLE_FILLED \
			rect			350 355 600 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name bottom_gradient \
			style			WINDOW_STYLE_FILLED \
			rect			0 600 854 30 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .2 \
			visible			1 \
			decoration \
		} \
		itemDef \
		{ \
			name vertical_line1 \
			style			WINDOW_STYLE_FILLED \
			rect			350 0 1 800 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			type			ITEM_TYPE_TEXT \
			visible		1 \
			origin			410 30 \
			forecolor		COLOR_TITLE \
			text			"^6Loadout  " \
			textfont		.7 \
			textscale		TEXTSIZE_TITLE \
			decoration \
		} \
		
#define STYLE_SETUP \
		itemDef \
		{ \
			style			WINDOW_STYLE_FILLED \
			rect			0 0 640 480 HORIZONTAL_ALIGN_FULLSCREEN VERTICAL_ALIGN_FULLSCREEN \
			backcolor		0 0 0 1 \
			visible			1 \
			decoration \
		} \
		itemDef \
		{ \
			name top_gradient \
			style			WINDOW_STYLE_FILLED \
			rect			0 0 854 30 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .2 \
			visible		1 \
			decoration \
		} \
		itemDef \
		{ \
			name horizontal_line1 \
			style			WINDOW_STYLE_FILLED \
			rect			0 30 854 1 HORIZONTAL_ALIGN_FULLSCREEN 0 \
			backcolor            1 1 1 .3 \
			visible		1 \
			decoration \
		} \

#define h_none \
			setdvar highlight_none "1"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text ""; \
			
#define h_no_attachments \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text ""; \

#define h_bayonet \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "1"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text " + Bayonet"; \
			
#define h_aperture \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "1"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text " + Aperture"; \
			
#define h_telescopic \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "1"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text " + Telescopic"; \
			
#define h_gl \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "1"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text " + Grenade Launcher"; \
			
#define h_ammo \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "1"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text " + Ammo Drum"; \
			
#define h_bipod \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "1"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text " + Bipod"; \
			
#define h_sawed \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "1"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text ""; \
			
#define h_grip \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "1"; \
			setdvar highlight_scope "0"; \
			setdvar attachment_text " + Grip"; \
			
#define h_scope \
			setdvar highlight_none "0"; \
			setdvar highlight_bayonet "0"; \
			setdvar highlight_aperture "0"; \
			setdvar highlight_telescopic "0"; \
			setdvar highlight_gl "0"; \
			setdvar highlight_ammo "0"; \
			setdvar highlight_bipod "0"; \
			setdvar highlight_sawed "0"; \
			setdvar highlight_grip "0"; \
			setdvar highlight_scope "1"; \
			setdvar attachment_text " + Scope"; \
			
#define h_springfield \
			setdvar highlight_springfield "1"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_kar98k \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "1"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_ptrs41 \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "1"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_gewehr43 \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "1"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_m1garand \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "1"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_m1carbine \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "1"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \

#define h_thompson \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "1"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_mp40 \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "1"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_stg44 \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "1"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_shotgun \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "1"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_doublebarrel \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "1"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_bar \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "1"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_fg42 \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "1"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_mg42 \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "1"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
			
#define h_30cal \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "1"; \
			setdvar highlight_dp28 "0"; \
			
#define h_dp28 \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "1"; \
			
#define h_no_weapons \
			setdvar highlight_springfield "0"; \
			setdvar highlight_kar98k "0"; \
			setdvar highlight_ptrs41 "0"; \
			setdvar highlight_gewehr43 "0"; \
			setdvar highlight_m1garand "0"; \
			setdvar highlight_m1carbine "0"; \
			setdvar highlight_thompson "0"; \
			setdvar highlight_mp40 "0"; \
			setdvar highlight_stg44 "0"; \
			setdvar highlight_shotgun "0"; \
			setdvar highlight_doublebarrel "0"; \
			setdvar highlight_bar "0"; \
			setdvar highlight_fg42 "0"; \
			setdvar highlight_mg42 "0"; \
			setdvar highlight_30cal "0"; \
			setdvar highlight_dp28 "0"; \
		
#define W_ALL \
		setDvar show_bayonet "1" \
		setDvar show_aperture "1" \
		setDvar show_tel "1" \
		setDvar show_gl "1" \
		setDvar show_ammo "1" \
		setDvar show_grip "0" \
		setDvar show_bipod "0" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \
		
#define W_BOLT \
		setDvar show_bayonet "1" \
		setDvar show_aperture "0" \
		setDvar show_tel "0" \
		setDvar show_gl "1" \
		setDvar show_ammo "0" \
		setDvar show_grip "0" \
		setDvar show_bipod "0" \
		setDvar show_scope "1" \
		setDvar show_sawed "0" \
		
#define W_RIFLE_1 \
		setDvar show_bayonet "0" \
		setDvar show_aperture "1" \
		setDvar show_tel "1" \
		setDvar show_gl "1" \
		setDvar show_ammo "0" \
		setDvar show_grip "0" \
		setDvar show_bipod "0" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \

#define W_RIFLE_2 \
		setDvar show_bayonet "0" \
		setDvar show_aperture "1" \
		setDvar show_tel "1" \
		setDvar show_gl "0" \
		setDvar show_ammo "0" \
		setDvar show_grip "0" \
		setDvar show_bipod "0" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \
		
#define W_RIFLE_3 \
		setDvar show_bayonet "1" \
		setDvar show_aperture "1" \
		setDvar show_tel "0" \
		setDvar show_gl "0" \
		setDvar show_ammo "1" \
		setDvar show_grip "0" \
		setDvar show_bipod "0" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \
		
#define W_RIFLE_4 \
		setDvar show_bayonet "1" \
		setDvar show_aperture "1" \
		setDvar show_tel "0" \
		setDvar show_gl "1" \
		setDvar show_ammo "0" \
		setDvar show_grip "0" \
		setDvar show_bipod "0" \
		setDvar show_scope "1" \
		setDvar show_sawed "0" \
		
#define W_SUB \
		setDvar show_bayonet "0" \
		setDvar show_aperture "1" \
		setDvar show_tel "0" \
		setDvar show_gl "0" \
		setDvar show_ammo "1" \
		setDvar show_grip "0" \
		setDvar show_bipod "0" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \
		
#define W_SHOT \
		setDvar show_bayonet "1" \
		setDvar show_aperture "0" \
		setDvar show_tel "0" \
		setDvar show_gl "0" \
		setDvar show_ammo "0" \
		setDvar show_grip "1" \
		setDvar show_bipod "0" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \
		
#define W_SHOT_2 \
		setDvar show_bayonet "0" \
		setDvar show_aperture "0" \
		setDvar show_tel "0" \
		setDvar show_gl "0" \
		setDvar show_ammo "0" \
		setDvar show_grip "1" \
		setDvar show_bipod "0" \
		setDvar show_scope "0" \
		setDvar show_sawed "1" \

#define W_MACHINE_1 \
		setDvar show_bayonet "0" \
		setDvar show_aperture "0" \
		setDvar show_tel "0" \
		setDvar show_gl "0" \
		setDvar show_ammo "0" \
		setDvar show_grip "0" \
		setDvar show_bipod "1" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \

#define W_MACHINE_2 \
		setDvar show_bayonet "0" \
		setDvar show_aperture "0" \
		setDvar show_tel "1" \
		setDvar show_gl "0" \
		setDvar show_ammo "0" \
		setDvar show_grip "0" \
		setDvar show_bipod "1" \
		setDvar show_scope "0" \
		setDvar show_sawed "0" \
		
#define C_ALL \
		close classmenu \
		close support_class \
		close kit_support \
		close w_bolt \
		close w_bolt_attachments_support \
